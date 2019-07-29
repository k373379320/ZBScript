#!/usr/bin/ruby

##################################
#
# 把PROJECT_PATH 里面的png图片,提取到IMAGE_TARGET_DIR文件夹
# 文件的名字是除了PROJECT_PATH意外的字符串,“/”换成“💧”
##################################

require 'find'
require 'fileutils'


PROJECT_PATH = ""
IMAGE_TARGET_DIR = ""

puts "查询项目中的image文件"

def copy_image_to_target_dir()
	Find.find(PROJECT_PATH,ignore_error: true) do |path|
		extname = File.extname(path) 
		if extname.include?"png"
			puts path
			name_start = IMAGE_TARGET_DIR.length
			#clone一份			
			image_name=path.clone
			#把PROJECT_PATH的换成“”
			image_name[0..name_start]=""
			#替换/
			image_name=image_name.tr('/','💧')  
			#生成图片名字
			target_image_path =  "#{IMAGE_TARGET_DIR}/#{image_name}"
			#cp
			FileUtils.cp(path, target_image_path)
		end
	end
end


copy_image_to_target_dir()