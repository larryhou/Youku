<?php
	header("Access-Control-Allow-Origin: http://www.flvcd.com");
	
	$tv = iconv("gbk", "utf-8", $_GET["tv"]);
	$episode = $_GET["episode"];
	if ($tv == "" || $episode == "") return;

	$output_dir = "./电视剧/$tv";

	if (!is_dir($output_dir)) 
	{
		$ret = mkdir($output_dir, 0777, true);
		if (!$ret) 
		{
			$data = array("title" => "上传异常", 
				"body" => "文件夹[$output_dir]创建失败，章节[$episode]内容无法写入服务器");
			echo json_encode($data);
			return;
		}
	}

	$content = file_get_contents("php://input");
	$file_path = "$output_dir/$episode.txt";
	$file = fopen($file_path, "w");
	fwrite($file, $content);
	fclose($file);

	$data = array('title' => "上传成功", 'body' => $file_path);
	echo json_encode($data);
?>