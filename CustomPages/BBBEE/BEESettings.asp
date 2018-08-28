<!-- #include file ="..\sagecrm.js" -->
<%

var customScreenBlock = CRM.GetBlock('entrygroup'); 
var customTextProxyAddr = CRM.GetBlock('entry');
var customCheckBox = CRM.GetBlock('entry');
var customCheckProxy = CRM.GetBlock('entry');
var customSelectionType = CRM.GetBlock('entry');
var customSelectionCat = CRM.GetBlock('entry');
var customTextProxyUser = CRM.GetBlock('entry');
var customTextProxyPass = CRM.GetBlock('entry');
var customCheckOverCert = CRM.GetBlock('entry');

with (customTextProxyAddr) 
{ 
EntryType = 10; 
DefaultType = 1 
DefaultValue = ''; 
FieldName = 'BBBEESpecialProxyAddr'; //field name in HTML form 
Caption = 'Proxy Server Address:'; 
CaptionPos = CapTop; // CRM caption location constants defined in eWare.js file 
maxLength = 60; 
}

with (customTextProxyUser) 
{ 
EntryType = 10; 
DefaultType = 1 
DefaultValue = ''; 
FieldName = 'BBBEESpecialProxyUser'; //field name in HTML form 
Caption = 'Proxy UserID:'; 
CaptionPos = CapTop; // CRM caption location constants defined in eWare.js file 
maxLength = 60; 
NewLine = false;
}

with (customTextProxyPass) 
{ 
EntryType = 10; 
DefaultType = 1 
DefaultValue = ''; 
FieldName = 'BBBEESpecialProxyPass'; //field name in HTML form 
Caption = 'Proxy Password:'; 
CaptionPos = CapTop; // CRM caption location constants defined in eWare.js file 
maxLength = 60; 
NewLine = false;
}

with (customCheckBox)
{ 
EntryType = 45;
DefaultType = 1;
FieldName = 'BBBEEDownloadCert'; //field name in HTML form 
Caption = 'Download PDF certificates'; 
CaptionPos = CapTop; // CRM caption location constants defined in eWare.js file 
NewLine = true;
}

with (customCheckOverCert)
{ 
EntryType = 45;
DefaultType = 1;
FieldName = 'BBBEEOverwritePrevCert'; //field name in HTML form 
Caption = 'Overwrite previously downloaded PDF'; 
CaptionPos = CapTop; // CRM caption location constants defined in eWare.js file 
NewLine = false;
}

with (customCheckProxy)
{ 
EntryType = 45;
DefaultType = 1;
FieldName = 'BBBEESpecialProxy'; //field name in HTML form 
Caption = 'Use Proxy server on CRM server'; 
CaptionPos = CapTop; // CRM caption location constants defined in eWare.js file 
}

with(customSelectionType) 
{ 
EntryType = 21;
AllowBlank = true //Relevant when EntryType = 21, adds blank option to drop down list. 
Caption = "Document Type"; 
CaptionPos = CapTop; // eWare caption location constants defined in eWare.js file 
FieldName = 'BBBEEDocumentType'; //This names the field;
LookUpFamily = "Libr_Type" //uses family for selection items. 
Size = 1; 
NewLine = true;
} 

with(customSelectionCat) 
{ 
EntryType = 21;
AllowBlank = true //Relevant when EntryType = 21, adds blank option to drop down list. 
Caption = "Document Category";
CaptionPos = CapTop; // eWare caption location constants defined in eWare.js file 
FieldName = 'BBBEEDocumentCat'; //This names the field;
LookUpFamily = "Libr_Category" //uses family for selection items. 
Size = 1; 
NewLine = false;
}

with(customScreenBlock) 
{ 
Title='BBBEE Settings Page'; 
AddBlock(customCheckProxy);
AddBlock(customTextProxyAddr); 
AddBlock(customTextProxyUser);
AddBlock(customTextProxyPass);

AddBlock(customCheckBox);
AddBlock(customCheckOverCert);
AddBlock(customSelectionType);
AddBlock(customSelectionCat);
} 

if (CRM.Mode == View) 
{ 
CRM.Mode = Edit; 
} 

CRM.AddContent(customScreenBlock.Execute()); 
Response.Write(CRM.GetPage()); //use default tab group 

if (CRM.Mode == Save) 
{ 
var arr = ["BBBEEDownloadCert","BBBEEOverwritePrevCert","BBBEESpecialProxy","BBBEESpecialProxyAddr","BBBEESpecialProxyUser","BBBEESpecialProxyPass","BBBEEDocumentType","BBBEEDocumentCat"];
for(var i = 0; i < 8; i++)
{
var beerecord = CRM.FindRecord("Custom_sysparams","parm_name = '"+arr[i]+"'");

var fieldname = beerecord("parm_Name");
var val = Request.Form(fieldname);



if(val == "on"){ val = "Y"};
else if(!Defined(val)){val = ""};

Response.Write(fieldname+": "+val+"</br>");

beerecord("parm_Value") = val;
beerecord.SaveChanges();
}
}

%>