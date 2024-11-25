USE [HSSportsDB]
GO

sp_help '[STAGING].[vw_H+ Sport FACT sales data_145843_CSV_duplicates]'

SELECT TOP 10 * FROM [STAGING].[vw_H+ Sport FACT sales data_145843_CSV_duplicates];

select  min(TotalSale  ) as min_value,
       max(TotalSale) as max_value,
        avg(TotalSale) as avg_value,
        stdev(TotalSale) as stdev_value,
        var(TotalSale) as var_value 
from [STAGING].[vw_H+ Sport FACT sales data_145843_CSV_duplicates]  salesdata

select  min(TotalSale  ) as min_value,
       max(TotalSale) as max_value,
        avg(TotalSale) as avg_value,
        stdev(TotalSale) as stdev_value,
        var(TotalSale) as var_value 
from [STAGING].[vw_H+ Sport FACT sales data_145843_CSV_NOduplicates]  salesdata
 strTmp = strMayBeNumber;
		var iEnd = strTmp.length;
		for (var i=0; i<iEnd; i++)
		{
			  var ch = strTmp.charAt(i);
			  if (!((ch == "0") || (ch == "1") ||
			        (ch == "2") || (ch == "3") ||
			        (ch == "4") || (ch == "5") ||
			        (ch == "6") || (ch == "7") ||
			        (ch == "8") || (ch == "9")))
			      return GetTopicNumberById(strTmp);
		}
		nNum = parseInt(strTmp);
   }
   return nNum;
}

function GetTopicNumber(strHashString)
{
	var nTopicEndPos = strHashString.indexOf(',')
	if (nTopicEndPos == -1) { // no window option.
		return GetTopicNumberOnly(strHashString);
	}
	else {
		var strWindowOption = strHashString.substring(nTopicEndPos + 1, strHashString.length);
		var strWithNavPane = 'withnavpane=true';
		if (strWindowOption.toLowerCase().indexOf(strWithNavPane) == 0)
		{
			if (strWindowOption.length > strWithNavPane.length)
				gstrWindowOption = strWindowOption.substring(strWithNavPane.length + 1);
			else
				gstrWindowOption = "";
			gbWithNavPane = true;
		}
		else
			gstrWindowOption = strWindowOption;
		return GetTopicNumberOnly(strHashString.substring(0, nTopicEndPos));		
	}
}

function GetTopicNumberOnly(strTopicString)
{
	var nEqualPos = strTopicString.indexOf('=');
	if (nEqualPos == -1) {
		return GetTopicNumberAuto(strTopicString);
	}
	else {
		var strValue=strTopicString.substring(nEqualPos + 1, strTopicString.length);
		if (strTopicString.toLowerCase().indexOf("topicnumber") == 0) {
			return parseInt(strValue);
		} else if (strTopicString.toLowerCase().indexOf("context") == 0) {
			return GetTopicNumberById(strValue);
		} else if (strTopicString.toLowerCase().indexOf("remoteurl") == 0) {
			gstrURL = strValue;
			return -1;
		}

	}
}

//Find HomePage of the WebHelp system
// we try to get the topic from remote project if it exists.
function RedirectToHomePage()
{
	if (parent && parent != this && parent.goNext)
	{
		var sHome = parent.goNext();
		if (sHome != "")
			RedirectTo(sHome);
	}
}

function getHomePage()
{
	if (parent && parent != this && parent.getRelHomePage)
	{
		return parent.getRelHomePage(document.location.href);
	}
	return "";
}

function addRemoteProject(strPath)
{
	if (parent && parent != this && parent.addProject)
	{
		parent.addProject(strPath);
	}
}

//Redirect page to...
function RedirectTo(strUrl)
{
   if (gstrWindowOption.length != 0) {
		var wnd = window.open(strUrl, "HelpStub", gstrWindowOption);
		// close current window and rename the stub window to current window.
		if (wnd)
			wnd.focus();
		if (parent)
			parent.close();
   }
   else {
	parent.document.location.href = strUrl;
	window.focus();
  }
}

//Prompt the user that we can not find...
function FailToFind(strMsg)
{
    RedirectToHomePage();
}

//Find topic by topic number (defined in h file)
function FindTopicByTopicNum(nTopicNum)
{
	var i = 0;
	var iEnd = gArrayCsh.length;
	for (i=0; i<iEnd; i++)
	{
		if (gArrayCsh[i].nTopicNum == nTopicNum)
		{
			var strURL = gArrayCsh[i].strUrl;
			if (gbWithNavPane)
			{
				var strHomePage = getHomePage();
				if (strHomePage.length != 0)
					strURL = strHomePage + strURL;
			}	
			RedirectTo(strURL);
			return true;
		}
	}
	FailToFind("Fail to find topic assocaite with topic number: " + nTopicNum);
	return false;
}

//Find topic by topic id (alias id defined in ali file)
function GetTopicNumberById(strTopicId)
{
   var i = 0;
   var iEnd = gArrayCsh.length;
   for (i=0; i<iEnd; i++)
   {
	if (gArrayCsh[i].strAliasId.toLowerCase() == strTopicId.toLowerCase())
	{
	    return gArrayCsh[i].nTopicNum;
	 }
   }
   gstrURL = "";
   return -1;
}

//Set Context-sensitive help entity...
function SetCsh(n, strAliasId, nTopicNum, strUrl)
{
   gArrayCsh[n] = new CshEntityItem(strAliasId,nTopicNum,strUrl);
}


function getHash()
{
	if (parent && parent != this)
		return parent.location.hash;
	else
		return "";
}
//-->
</script>
<script language="javascript">
<!--


//-->
</script>
<script language="javascript">
<!--
//Find CSH according to hash string after this page
if (getHash().length > 0)
{
   // VH 05/16/00 now support 
   // TopicID=
   // TopicNumber=
   // RemoteURL=   
   // and WindowsOptions
   // with the format #a=xxx,b=xxx,c=xxx...
   var strHashString = getHash().toString();
   // change ? to : for remote URL. because java applet have some problem to pass a URL with two : inside the URL so we changed it. 
   // so here need to change it back.
   strHashString = strHashString.substring(1,strHashString.length);
   strHashString = strHashString.replace("%072%057%057", "://");
   var nTopicNum = GetTopicNumber(strHashString);

   if (nTopicNum != -1)
   {
      FindTopicByTopicNum(nTopicNum);
   }
   else
   {
      if (gstrURL.length > 0) 
	RedirectTo(gstrURL);
      else
      	RedirectToHomePage();
   }
}
else
{
   RedirectToHomePage();
}
//-->
</script>
<noscript>
 <p> Your browser does not support JavaScript. WebHelp Context-Sensitive Help requires JavaScript support to run.</p>
</noscript>
</body>
</html>






