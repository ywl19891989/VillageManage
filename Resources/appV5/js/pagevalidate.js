function IsEmail(email){
 var regext = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
 return(regext.test(email));
}

function IsMobile(inputData){
	  //电信手机号码正则        
            var dianxin = /^1[3578][01379]\d{8}$/;
             
            //联通手机号正则        
            var liantong = /^1[34578][01256]\d{8}$/;
           
            string yidong = /"^(134[012345678]\d{7}|1[34578][012356789]\d{8})$/;
            var yReg = new Regex(yidong);
            return (dReg.test(inputData) || tReg.test(inputData) || yReg.test(inputData))
              
}

// <summary>
		/// 是否数字字符串
		/// </summary>
		/// <param name="inputData">输入字符串</param>
		/// <returns></returns>
		function  IsNumber(string inputData)
		{
			var regMatch = /^[0-9]+$/;
			 
			return regMatch.test(inputData);
		}		
		 	
		/// <summary>
		/// 是否是浮点数
		/// </summary>
		/// <param name="inputData">输入字符串</param>
		/// <returns></returns>
		function   IsDecimal(string inputData)
		{
			var regMatch = /^[0-9]+[.]?[0-9]+$/;
			return regMatch.test(inputData);
		}

        /// <summary>
        /// 是否是浮点数
        /// </summary>
        /// <param name="inputData">输入字符串</param>
        /// <returns></returns>
        function   IsIntOrDecimal(string inputData)
        {
           return IsNumber(inputData) || IsDecimal(inputData);
        }	
function IsEmpty(name){
 	return !name && typeof(name)!="undefined" && name!=0
}

function createNos(var uid){
	 var now = new Date();
    var year = now.getFullYear(); //getFullYear getYear
    var month = now.getMonth();
    var date = now.getDate();
    var day = now.getDay();
    var hour = now.getHours();
    var minu = now.getMinutes();
    var sec = now.getSeconds();
    return year +month +date +hour +minu +sec +uid;
}

function IsDateTime(inputData){
	var regDtMatch1 = /\b(?<year>\d{2,4})/(?<month>\d{1,2})/(?<day>\d{1,2})\b/; 
	var regDtMatch2 = /\b(?<year>\d{2,4})-(?<month>\d{1,2})-(?<day>\d{1,2})\b/;  
	return regDtMatch1.test(inputData) || regDtMatch2.test(inputData);
}
		 