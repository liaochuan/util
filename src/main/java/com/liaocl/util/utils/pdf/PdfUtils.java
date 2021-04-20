package com.liaocl.util.utils.pdf;

import java.awt.Color;
import java.awt.image.BufferedImage;
import java.io.BufferedOutputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

import javax.imageio.ImageIO;

import com.liaocl.util.utils.common.StringUtils;
import org.apache.pdfbox.contentstream.operator.Operator;
import org.apache.pdfbox.cos.COSArray;
import org.apache.pdfbox.cos.COSString;
import org.apache.pdfbox.pdfparser.PDFStreamParser;
import org.apache.pdfbox.pdfwriter.ContentStreamWriter;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageTree;
import org.apache.pdfbox.pdmodel.common.PDStream;
import org.springframework.core.io.ClassPathResource;

import com.lowagie.text.BadElementException;
import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Element;
import com.lowagie.text.Image;
import com.lowagie.text.Rectangle;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfContentByte;
import com.lowagie.text.pdf.PdfCopy;
import com.lowagie.text.pdf.PdfGState;
import com.lowagie.text.pdf.PdfImportedPage;
import com.lowagie.text.pdf.PdfReader;
import com.lowagie.text.pdf.PdfStamper;

public class PdfUtils {

    private static final Pattern IMG_PATTERN = Pattern.compile(".*[.](jpg|png|bmp|gif)$");
    private static final Pattern PDF_PATTERN = Pattern.compile(".*[.]pdf$");

    public static void mergePdfFile(List<File> sourceFrList, File destFr) {
        if (sourceFrList == null || sourceFrList.size() == 0) {
            return;
        }
        List<String> sourceFilePathList = sourceFrList.stream().map(s -> {
            return s.getAbsolutePath().toString();
        }).collect(Collectors.toList());
        String destFilePath = destFr.getAbsolutePath().toString();
        mergePdfFile(sourceFilePathList, destFilePath);
    }

    public static void mergePdfFile(List<String> sourceFilePathList, String destFilePath) {
        if (sourceFilePathList == null || sourceFilePathList.size() == 0) {
            return;
        }
        Document document = null;
        PdfCopy copy = null;
        OutputStream os = null;
        try {
            Path dirPath = Paths.get(destFilePath.substring(0, destFilePath.lastIndexOf(File.separator)));
            Files.createDirectories(dirPath);

            os = new BufferedOutputStream(new FileOutputStream(new File(destFilePath)));
            document = new Document(new PdfReader(sourceFilePathList.get(0)).getPageSize(1));
            copy = new PdfCopy(document, os);
            document.open();
            for (String sourceFilePath : sourceFilePathList) {
                PdfReader reader = new PdfReader(sourceFilePath);
                int n = reader.getNumberOfPages();
                for (int j = 1; j <= n; j++) {
                    document.newPage();
                    PdfImportedPage page = copy.getImportedPage(reader, j);
                    copy.addPage(page);
                }
            }
        } catch (Exception e) {
        	throw new RuntimeException("合并PDF失败！："+ e);
        } finally {
            if (copy != null) {
                try {
                    copy.close();
                } catch (Exception ex) {
                    /* ignore */
                }
            }
            if (document != null) {
                try {
                    document.close();
                } catch (Exception ex) {
                    /* ignore */
                }
            }
            if (os != null) {
                try {
                    os.close();
                } catch (Exception ex) {
                    /* ignore */
                }
            }
        }
    }

    /**
     * 
     * @param imgPath
     *            图片路径
     * @param n
     *            需要分割的份数
     * @return 分割后的图片
     * @throws IOException
     * @throws BadElementException
     */
    private static Image[] subImages(String imgPath, int n) {
        Image[] nImage = new Image[n];
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        BufferedImage img = null;
        try {
            img = ImageIO.read(new File(imgPath));
            int h = img.getHeight();
            int w = img.getWidth();

            int sw = w / n;
            for (int i = 0; i < n; i++) {
                BufferedImage subImg = null;
                if (i == n - 1) {// 最后剩余部分
                    subImg = img.getSubimage(i * sw, 0, w - i * sw, h);
                } else {// 前n-1块均匀切
                    subImg = img.getSubimage(i * sw, 0, sw, h);
                }
                int alphaCompare = img.getRGB(0, 0);
                nImage[i] = getAlphaImage(subImg, 160, alphaCompare);
                out.flush();
                out.reset();
            }

        } catch (Exception e) {
        	throw new RuntimeException("加盖骑缝章失败！："+ e);
        } finally {

            if (out != null) {
                try {
                    out.flush();
                    out.close();
                } catch (Exception e) {
                    /* ignore */
                }
            }

        }
        return nImage;
    }


    /**
     * 对图片进行透明处理，以保证不会对pdf内容完全遮挡
     * @param img 原图片
     * @param alpha 透明度，取值0-255
     * @param alphaCompare 透明对比点的RGB值
     * @return 透明处理后的图片
     * @throws IOException
     * @throws BadElementException
     */
    private static Image getAlphaImage(BufferedImage img, int alpha, int alphaCompare) {
    	Image image = null;
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        BufferedImage back=new BufferedImage(img.getWidth(), img.getHeight(), BufferedImage.TYPE_INT_ARGB);  
        int width = img.getWidth();    
        int height = img.getHeight();
        for (int j = 0; j < height; j++) {   
            for (int k = 0; k < width; k++) {
                int rgb = img.getRGB(k, j);
                if (rgb == alphaCompare) {
                	// 对比为透明点则处理为透明
                	back.setRGB(k, j, rgb & 0x00ffffff);
				} else {
                    Color color = new Color(rgb);
                    Color newcolor = new Color(color.getRed(), color.getGreen(),color.getBlue(), alpha);
                    back.setRGB(k, j,newcolor.getRGB());
				}
            }
        }
        try {
            // 透明图片格式需为png格式
			ImageIO.write(back, "png", out);
			image = Image.getInstance(out.toByteArray());
		} catch (IOException | BadElementException e) {
			throw new RuntimeException("加盖骑缝章时图片透明装换失败！："+ e);
		} finally {
            if (out != null) {
                try {
                    out.flush();
                    out.close();
                } catch (Exception e) {
                    /* ignore */
                }
            }
        }
    	return image;
    }
    
	/**
	 * 根据传入的关键字删除pdf文档中的相同文字
	 * @param keys 需删除的关键字（不支持中文），多个以英文逗号隔开的
	 * @param pdfPath pdf文件路径
	 */
	public static void removeKey(String keys, String pdfPath) {
		String[] key = keys.split(",");
		PDDocument pdDocument = null;
		try {
			pdDocument = PDDocument.load(new File(pdfPath));
			PDPageTree pages = pdDocument.getDocumentCatalog().getPages();
		    for (PDPage page : pages) {
		        PDFStreamParser parser = new PDFStreamParser(page);
		        parser.parse();
		        List<Object> tokens = parser.getTokens();
		        for (int j = 0; j < tokens.size(); j++) {
		            Object next = tokens.get(j);
		            if (next instanceof Operator) {
		                Operator op = (Operator) next;
		                if (op.getName().equals("Tj")) {
		                    COSString previous = (COSString) tokens.get(j - 1);
		                    String string = previous.getString();
		                    for(String k:key) {
		                    	if (String.valueOf(k).equals(string)) {
			                    	previous.setValue("".getBytes());
								}
		                    }
		                } else if (op.getName().equals("TJ")) {
		                    COSArray previous = (COSArray) tokens.get(j - 1);
		                    String temp = "";
		                    for (int k = 0; k < previous.size(); k++) {
		                        Object arrElement = previous.getObject(k);
		                        if (arrElement instanceof COSString) {
		                            COSString cosString = (COSString) arrElement;
		                            temp += cosString.getString();
		                        }
		                    }
		                    for(String k:key) {
			                    if (String.valueOf(k).equals(temp)) {
				                    for (int m = 0; m < previous.size(); m++) {
				                        Object arrElement = previous.getObject(m);
				                        if (arrElement instanceof COSString) {
				                            COSString cosString = (COSString) arrElement;
				                            cosString.setValue("".getBytes());
				                        }
				                    }
								}
		                    }
		                }
		            }
		        }
		        PDStream updatedStream = new PDStream(pdDocument);
		        OutputStream out = updatedStream.createOutputStream();
		        ContentStreamWriter tokenWriter = new ContentStreamWriter(out);
		        tokenWriter.writeTokens(tokens);
		        page.setContents(updatedStream);
		        out.close();
		    }
		    pdDocument.save(pdfPath);
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (pdDocument != null) {
				try {
					pdDocument.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}

    /**
     * 根据标记添加图片，并删除该标记文字
     *
     * @param pdfPath 需要添加图片的pdf文件路径
     * @param imagePath 图片路径，要求为jpg、png、bmp、gif格式
     * @param mark 标记文字，当有pdf文件中有多个相同的标记时只会取第一个标记的位置
     * @param alpha 透明度，取值0-255(0代表完全透明)
     * @param page 在pdf的第几页添加图片，当<=0时对所有页面都添加
     */
    public static void addImageByMark(String pdfPath, String imagePath, String mark, int alpha, int page) {
        if (IMG_PATTERN.matcher(imagePath).matches() && PDF_PATTERN.matcher(pdfPath).matches()) {
            File pdfFile = new File(pdfPath);
            PdfReader reader = null;
            String fileName = pdfFile.getAbsolutePath();  // 源文件的路径
            String newName = fileName.substring(0, fileName.lastIndexOf("."));
            newName = newName + "tem.pdf";  // 源文件tem.pdf
            File tempFile = new File(newName);
            FileOutputStream os = null;
            PdfStamper stamp = null;
            try {
                reader = new PdfReader(pdfFile.getAbsolutePath());
                os = new FileOutputStream(tempFile);
                stamp = new PdfStamper(reader, os);
                // 根据pdf的第一页获取pdf页面宽度
                Rectangle pageSize = reader.getPageSize(1);
                float width = pageSize.getWidth();
                BufferedImage bufferImg = ImageIO.read(new File(imagePath));
                int alphaCompare = bufferImg.getRGB(0, 0);
                Image image = getAlphaImage(bufferImg, alpha, alphaCompare);
                // 图片缩放，按照印章直径42mm和标准a4纸宽度210mm的比例进行印章大小调整
                float scalePercent = (float) ((width * 42/210) / image.getWidth());
                image.scalePercent(scalePercent*100);
                // 根据关键字查询印章位置
                PdfBoxKeyWordPosition position = new PdfBoxKeyWordPosition(mark, pdfFile.getAbsolutePath());
                List<float[]> list = position.getCoordinate();
                float[] fs = {0f,0f};
                if (list.size() > 0) {
                    fs = list.get(0);
                }
                if(page > 0){
                    PdfContentByte content = stamp.getOverContent(page);
                    image.setAbsolutePosition(fs[0] - (image.getWidth()*scalePercent)/2, fs[1] - (image.getHeight()*scalePercent) / 2);
                    content.addImage(image);
                } else {
                    int pageNum = reader.getNumberOfPages();
                    for(int n=1; n<=pageNum; n++){
                        PdfContentByte content = stamp.getOverContent(n);
                        image.setAbsolutePosition(fs[0] - (image.getWidth()*scalePercent)/2, fs[1] - (image.getHeight()*scalePercent) / 2);
                        content.addImage(image);
                    }
                }
            } catch (Exception e) {
                throw new RuntimeException("根据标记添加图片，并删除该标记文字失败！："+ e);
            } finally {
                if (stamp != null) {
                    try {
                        stamp.close();
                    } catch (Exception ex) {
                        /* ignore */
                    }
                }
                if (os != null) {
                    try {
                        os.flush();
                        os.close();
                    } catch (Exception ex) {
                        /* ignore */
                    }
                }
                if (reader != null) {
                    try {
                        reader.close();
                    } catch (Exception ex) {
                        /* ignore */
                    }
                }
            }
            pdfFile.delete();// 删除源文件
            tempFile.renameTo(new File(fileName));// 生成新的同名文件
            // 将标记文字删除
            removeKey(mark, fileName);
        } else {
        	 throw new RuntimeException("图片格式不正确！");
        }
    }

    /**
     * pdf文件增加印章、骑缝章、水印
     *
     * @param pdfFile 进行处理的pdf文件
     * @param sealFile 印章图片，在印章标记处添加，不需要添加则传null，要求为jpg、png、bmp、gif格式
     * @param sealmark 印章标记，多个以逗号隔开
     * @param ridesealFile 骑缝章图片，不需要添加则传null，要求为jpg、png、bmp、gif格式
     * @param ridesealstartpage 骑缝章开始打印页数，首页为1
     * @param waterMark 水印文字，若不需要水印则传空
     * @param color 水印颜色
     */
    public static void addStamp(File pdfFile, File sealFile, String sealmark, File ridesealFile, int ridesealstartpage, String waterMark, Color color) {
        // 文件类型校验
        if((pdfFile != null && !PDF_PATTERN.matcher(pdfFile.getName().toLowerCase()).matches()) ||
            (sealFile != null && !IMG_PATTERN.matcher(sealFile.getName().toLowerCase()).matches()) ||
            (ridesealFile != null && !IMG_PATTERN.matcher(ridesealFile.getName().toLowerCase()).matches())){
                throw new RuntimeException("pdf文件增加印章、骑缝章、水印时图片或pdf文件格式不正确！");
        }
        // 添加印章
        if(StringUtils.isNotEmpty(sealmark) && sealFile != null){
            addImageByMarks(pdfFile, sealFile, sealmark, 180);
        }
        // 添加骑缝章
        if(ridesealFile != null){
            addRideSeal(pdfFile, ridesealFile, ridesealstartpage);
        }
        // 添加水印
        if(StringUtils.isNotEmpty(waterMark)){
            addWaterMark(pdfFile, waterMark, color);
        }
    }

    /**
     * 根据标记添加图片，并删除该标记文字，标记可多个，会替换整个pdf文件中的所有标记
     *
     * @param pdfFile 需要添加图片的pdf文件
     * @param sealFile 印章图片，要求为jpg、png、bmp、gif格式
     * @param marks 标记文字，多个以逗号隔开
     * @param alpha 透明度，取值0-255(0代表完全透明)
     */
    public static void addImageByMarks(File pdfFile, File sealFile, String marks, int alpha) {
        if (IMG_PATTERN.matcher(sealFile.getName().toLowerCase()).matches() && PDF_PATTERN.matcher(pdfFile.getName().toLowerCase()).matches()) {
            PdfReader reader = null;
            String fileName = pdfFile.getAbsolutePath();  // 源文件的路径
            String newName = fileName.substring(0, fileName.lastIndexOf("."));
            newName = newName + "tem.pdf";  // 源文件tem.pdf
            File tempFile = new File(newName);
            FileOutputStream os = null;
            PdfStamper stamp = null;
            try {
                reader = new PdfReader(pdfFile.getAbsolutePath());
                os = new FileOutputStream(tempFile);
                stamp = new PdfStamper(reader, os);
                // 根据pdf的第一页获取pdf页面宽度
                Rectangle pageSize = reader.getPageSize(1);
                float width = pageSize.getWidth();
                BufferedImage bufferImg = ImageIO.read(sealFile);
                int alphaCompare = bufferImg.getRGB(0, 0);
                Image image = getAlphaImage(bufferImg, alpha, alphaCompare);
                // 图片缩放，按照印章直径42mm和标准a4纸宽度210mm的比例进行印章大小调整
                float scalePercent = (float) ((width * 42/210) / image.getWidth());
                image.scalePercent(scalePercent*100);
                // 根据关键字查询印章位置
                String[] markarray = marks.split(",");
                PdfBoxKeyWordPosition position;
                List<float[]> list;
                PdfContentByte content;
                for(String mark:markarray){
                    position = new PdfBoxKeyWordPosition(mark, pdfFile.getAbsolutePath());
                    list = position.getCoordinate();
                    if (list != null && list.size()>0) {
                        for(float[] fs:list){
                            content = stamp.getOverContent((int)fs[2]);
                            image.setAbsolutePosition(fs[0] - (image.getWidth()*scalePercent)/2, fs[1] - (image.getHeight()*scalePercent) / 2);
                            content.addImage(image);
                        }
                    }
                }
            } catch (Exception e) {
                throw new RuntimeException("根据标记添加图片，并删除该标记文字失败！："+ e);
            } finally {
                if (stamp != null) {
                    try {
                        stamp.close();
                    } catch (Exception ex) {
                        /* ignore */
                    }
                }
                if (os != null) {
                    try {
                        os.flush();
                        os.close();
                    } catch (Exception ex) {
                        /* ignore */
                    }
                }
                if (reader != null) {
                    try {
                        reader.close();
                    } catch (Exception ex) {
                        /* ignore */
                    }
                }
            }
            pdfFile.delete();// 删除源文件
            tempFile.renameTo(new File(fileName));// 生成新的同名文件
            // 将标记文字删除
            removeKey(marks, fileName);
        } else {
        	 throw new RuntimeException("根据标记添加图片时图片格式不正确！");
        }
    }

    /**
     * 添加骑缝章
     *
     * @param pdfFile 需要添加骑缝章的pdf文件
     * @param ridesealFile 骑缝章图片，要求为jpg、png、bmp、gif格式
     * @param ridesealstartpage 骑缝章开始打印页数，首页为1
     */
    public static void addRideSeal(File pdfFile, File ridesealFile, int ridesealstartpage) {
        if (IMG_PATTERN.matcher(ridesealFile.getName().toLowerCase()).matches() && PDF_PATTERN.matcher(pdfFile.getName().toLowerCase()).matches()) {
            FileOutputStream os = null;
            PdfStamper stamp = null;
            Image[] nImage = null;
            PdfReader reader = null;
            String fileName = pdfFile.getAbsolutePath();  // 源文件的路径
            String newName = fileName.substring(0, fileName.lastIndexOf("."));
            newName = newName + "tem.pdf";  // 源文件tem.pdf
            File tempFile = new File(newName);
            try {
                reader = new PdfReader(pdfFile.getAbsolutePath());
                os = new FileOutputStream(tempFile);
                stamp = new PdfStamper(reader, os);// 加完印章后的pdf
                Rectangle pageSize = reader.getPageSize(1);// 获得第一页
                float height = pageSize.getHeight();
                float width = pageSize.getWidth();
                int pdfpagenum = reader.getNumberOfPages();
                // 需要打印骑缝章的页数
                int nums = pdfpagenum - (ridesealstartpage - 1);
                // 图片缩放，按照印章直径42mm和标准a4纸宽度210mm的比例进行印章大小调整
                BufferedImage bufferImg = ImageIO.read(ridesealFile);
                float scalePercent = (float) ((width * 42/210) / bufferImg.getWidth());
                nImage = subImages(ridesealFile.getAbsolutePath(), nums);// 生成骑缝章切割图片
                for (int n = ridesealstartpage; n <= pdfpagenum; n++) {
                    PdfContentByte over = stamp.getOverContent(n);// 设置在第几页打印印章
                    Image img = nImage[n - ridesealstartpage];// 选择图片
                    // 图片缩放
                    img.scalePercent(scalePercent*100);
                    if(n == nums){               
                        img.setAbsolutePosition(width - (img.getWidth()*scalePercent + 8), height / 2 - (img.getHeight()*scalePercent) / 2);// 控制图片位置
                    }else{
                        img.setAbsolutePosition(width - (img.getWidth()*scalePercent), height / 2 - (img.getHeight()*scalePercent) / 2);// 控制图片位置
                    }
                    over.addImage(img);
                }
            } catch (DocumentException | IOException e) {
                throw new RuntimeException("添加骑缝章失败！："+ e);
            } finally {
                if (stamp != null) {
                    try {
                        stamp.close();
                    } catch (Exception ex) {
                        /* ignore */
                    }
                }
                if (os != null) {
                    try {
                        os.flush();
                        os.close();
                    } catch (Exception ex) {
                        /* ignore */
                    }
                }
                if (reader != null) {
                    try {
                        reader.close();
                    } catch (Exception ex) {
                        /* ignore */
                    }
                }
            }
            pdfFile.delete();// 删除源文件
            tempFile.renameTo(new File(fileName));// 生成新的同名文件
        } else {
            throw new RuntimeException("添加骑缝章时图片格式不正确！");
        }
    }

    /**
     * 添加水印
     *
     * @param pdfFile 需要添加骑缝章的pdf文件
     * @param waterMark 水印文字
     */
    public static void addWaterMark(File pdfFile, String waterMark, Color color) {
        if (StringUtils.isNotEmpty(waterMark) && PDF_PATTERN.matcher(pdfFile.getName().toLowerCase()).matches()) {
            FileOutputStream os = null;
            PdfStamper stamp = null;
            PdfReader reader = null;
            String fileName = pdfFile.getAbsolutePath();  // 源文件的路径
            String newName = fileName.substring(0, fileName.lastIndexOf("."));
            newName = newName + "tem.pdf";  // 源文件tem.pdf
            File tempFile = new File(newName);
            try {
                reader = new PdfReader(pdfFile.getAbsolutePath());
                os = new FileOutputStream(tempFile);
                stamp = new PdfStamper(reader, os);
                Rectangle pageSize = reader.getPageSize(1);// 获得第一页
                float height = pageSize.getHeight();
                float width = pageSize.getWidth();

                int nums = reader.getNumberOfPages();
                // 设置字体
                String path = new ClassPathResource("file/font/HtowertI.TTF").getPath();
                BaseFont bFont = BaseFont.createFont(path, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
                // BaseFont bFont = BaseFont.createFont(BaseFont.TIMES_BOLD, BaseFont.CP1252, BaseFont.EMBEDDED);
                PdfGState gs = new PdfGState();
                for (int n = 1; n <= nums; n++) {
                    PdfContentByte over = stamp.getOverContent(n);
                    // 水印开始
                    over.beginText();
                    // 设置水印透明度
                    gs.setFillOpacity(0.1f);
                    over.setGState(gs);
                    over.setColorFill(color);
                    // 设置字体及字号
                    over.setFontAndSize(bFont, 11);
                    // 设置水印内容及位置
                    for (int i = 0; i < 11; i++) {
                        for (int j = 0; j < 8; j++) {
                            over.showTextAligned(Element.ALIGN_LEFT, waterMark, (float) (width * 0.04 + width * j / 8),
                                    (float) (height * 0.03 + height * i / 11), 45);
                        }
                    }
                    // 水印结束
                    over.endText();
                }
            } catch (DocumentException | IOException e) {
                throw new RuntimeException("添加水印失败！："+ e);
            } finally {
                if (stamp != null) {
                    try {
                        stamp.close();
                    } catch (Exception ex) {
                        /* ignore */
                    }
                }
                if (os != null) {
                    try {
                        os.flush();
                        os.close();
                    } catch (Exception ex) {
                        /* ignore */
                    }
                }
                if (reader != null) {
                    try {
                        reader.close();
                    } catch (Exception ex) {
                        /* ignore */
                    }
                }
            }
            pdfFile.delete();// 删除源文件
            tempFile.renameTo(new File(fileName));// 生成新的同名文件
        } else {
            throw new RuntimeException("添加水印时pdf文件格式不正确或水印文字为空！");
        }
    }
	
}