package kr.green.mytrip.utills;

import java.io.File;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.UUID;

import org.springframework.util.FileCopyUtils;

import kr.green.mytrip.vo.ActivityVO;

public class UploadFileUtills {
	public static String uploadFile(String uploadPath, String originalName, byte[] 	
			fileData)throws Exception{
		UUID uid = UUID.randomUUID();
		String savedName = uid.toString() +"_" + originalName;
		String savedPath = calcPath(uploadPath);
		File target = new File(uploadPath + savedPath, savedName);
		FileCopyUtils.copy(fileData, target);
		String uploadFileName = makeIcon(uploadPath, savedPath, savedName);
		return uploadFileName;
	}
	
	//활동사진 저장
	public static String uploadActivityImg(String uploadPath, String originalName, byte[] 	
			fileData, ActivityVO activity)throws Exception{
		UUID uid = UUID.randomUUID();
		String savedName = uid.toString() +"_" + originalName;
		String savedPath = calcActivityImgPath(uploadPath, activity);
		File target = new File(uploadPath + savedPath, savedName);
		FileCopyUtils.copy(fileData, target);
		String uploadFileName = makeIcon(uploadPath, savedPath, savedName);
		return uploadFileName;
	}
	
	//활동 사진이 저장될 위치
	private static String calcActivityImgPath(String uploadPath, ActivityVO activity) {
		String idPath = File.separator+activity.getAc_me_id();
		String trPath = idPath + File.separator+ activity.getAc_tr_num();
		String acPath = trPath + File.separator+ activity.getAc_num();
		
		makeDir(uploadPath, idPath, trPath, acPath);
		return acPath;
 
	}
	
	
	//프로필사진
	public static String uploadProfile(String uploadPath, String originalName,
			byte[] fileData, String me_id)throws Exception{
		
		//UUID를 발급.  파일 이름이 중복되어도 해당 파일이 유일하게 되도록 발급되는 일련번호
		UUID uid = UUID.randomUUID();
		
		//파일명 앞에  UUID를 추가하는 코드
		String savedName = uid.toString() +"_" + originalName;
		
		//savedPath :  me_id를 기준으로 한 문자열
		String savedPath = calcPath(uploadPath, me_id);
		
		//uploadPath와 savedPath로 이루어진 경로에 파일이름이 savedName인 빈 파일을 생성
		File target = new File(uploadPath + savedPath, savedName);
		//파일 복사. fildeData에 있는 파일을 target에 복사
		FileCopyUtils.copy(fileData, target);
		
		//savedPath와 savedName을 이용하여 문자열을 만듦.
		//\\2022\\01\\14\\550e8400-e29b-41d4-a716-446655440000_a.jpg
		String uploadFileName = makeIcon(savedPath, savedName);
		return uploadFileName;
		}
	
	
	
	
	//프로필사진
	public static void makeIdDir(String uploadPath, String paths) {
		if(new File(uploadPath + paths).exists())
			return;
		File dirPath = new File(uploadPath + paths);
		//해당 경로에 임시 폴더와 같은 폴더가 없으면
		if( !dirPath.exists())
			//해당 폴더를 실제로 만듦
			dirPath.mkdir();
	}
	
	
	public static String calcPath(String uploadPath, String me_id) {
		String idPath = File.separator+me_id;
		makeIdDir(uploadPath, idPath);
		return idPath;
	}
	
	private static String calcPath(String uploadPath) {
		Calendar cal = Calendar.getInstance();
		
		String yearPath = File.separator+cal.get(Calendar.YEAR);
		String monthPath = yearPath + File.separator 
            + new DecimalFormat("00").format(cal.get(Calendar.MONTH)+1);
		String datePath = monthPath + File.separator 
            + new DecimalFormat("00").format(cal.get(Calendar.DATE));
		makeDir(uploadPath, yearPath, monthPath, datePath);
		
		return datePath;
 
	}
	private static void makeDir(String uploadPath, String... paths) {
		if(new File(paths[paths.length-1]).exists())
			return;
		for(String path : paths) {
			File dirPath = new File(uploadPath + path);
			if( !dirPath.exists())
				dirPath.mkdir();
		}
	}
	
	private static String makeIcon(String uploadPath, String path, String fileName)
        	throws Exception{
		String iconName = uploadPath + path + File.separator + fileName;
		return iconName.substring(uploadPath.length()).replace(File.separatorChar, '/');
	}
	
	//최종적으로 가져올 때 \를 최종적으로 /로 바꿔주는 역할을 함
	public static String makeIcon(String path, String fileName)
        	throws Exception{
		
		String iconName = path + File.separator + fileName;
		return iconName.replace(File.separatorChar, '/');
	}

}