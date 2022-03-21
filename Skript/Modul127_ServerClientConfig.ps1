

[void] [System.Reflection.Assembly]LoadWithPartialName(System.Drawing) 
[void] [System.Reflection.Assembly]LoadWithPartialName(System.Windows.Forms)
[void] [System.Reflection.Assembly]LoadWithPartialName(Security.Principal.WindowsIdentity)
#--------------------Determinate OS Version Server or not---------------
#region Determinate OS Version and variable set 

$os = Get-WmiObject -Class Win32_OperatingSystem -ComputerName $envCOMPUTERNAME
if($os.Caption -match Microsoft Windows Server){ 
$WsActive = $false 
$SrvActive = $true
$CompName='MetalWurmSRV101'
$Password='did1Srvp!'
}else{
$WsActive = $true 
$SrvActive = $false
$Password=did1WSp!
$CompName='MetalWurmWS101'
}
#endregion

function Test-Administrator ()
{  
   $currentPrincipal = New-Object Security.Principal.WindowsPrincipal( [Security.Principal.WindowsIdentity]GetCurrent() )
   $currentPrincipal.IsInRole( [Security.Principal.WindowsBuiltInRole]Administrator )
   }

#--------------------Funktion Create User---------------------
#region Funktion Create User
function CreateUser ($User){

$Computername = $envCOMPUTERNAME
$ADSIComp = [adsi]WinNT$Computername
$NewUser = $ADSIComp.Create('User',$User.Username)
$NewUser.SetPassword($User.Passwort)
$NewUser.SetInfo()
$NewUser.put(Description,$User.Beschriebung)
$FullName= $User.Vorname + ' ' +$User.Name
$NewUser.put(FullName,$FullName)
$NewUser.SetInfo()
}
#endregion


#--------------------Funktion Reset Computername ---------------------
#region Funktion Create User
function RenameComputer ($Name){
$comp = Get-WmiObject -Class Win32_ComputerSystem
$comp.Rename($Name)
}
#endregion

#--------------------Funktion Reset Admin PW---------------------
#region FunktionReset Admin PW
function ResetAdminPW ($Passwd){

$Computername = $envCOMPUTERNAME
$AdmUser= $envUSERNAME
$ADSIUser = [adsi]WinNT$Computername$AdmUser,user
$ADSIUser.SetPassword($Passwd)
$ADSIUser.SetInfo()
}
#endregion



#--------------------Create Publicshare for all User---------------------
#region Funktion create share for all User
function CreatePubShare($SharePath = CAlleDaten){
 if (Test-Path -Path ($SharePath)){
}else{
New-Item -Path $SharePath -type directory
New-SmbShare –Name AlleDaten –Path $SharePath -FullAccess Jeder
	}
}
#endregion

#--------------------Create Homeshare for all User---------------------
#region Create Userhome and  Home drive Share
function CreateUserhome ($HomePath =cBenutzerverzeichnis, $User ){
if (Test-Path -Path $HomePath){ }else{New-Item -Path $HomePath -type directory}
 
$UserHome = $HomePath++$User.Homedrive.ToString()

if (Test-Path -Path $UserHome){
}else{
#Create Userhome and Share
New-Item -Path $UserHome -type directory
$FullAccess = $Computername++$User.UserName.ToString()
New-SmbShare –Name $User.UserName.ToString() –Path $UserHome -FullAccess $FullAccess
#Set NTFS Permission to Homedriver
$acl = Get-Acl $UserHome
$acl.SetAccessRuleProtection($True, $False)
#Add User
$rule = New-Object System.Security.AccessControl.FileSystemAccessRule($User.UserName.ToString(),FullControl, ContainerInherit, ObjectInherit, None, Allow)
$acl.AddAccessRule($rule)
#Add Administrators
$rule = New-Object System.Security.AccessControl.FileSystemAccessRule(Administratoren,FullControl, ContainerInherit, ObjectInherit, None, Allow)
$acl.AddAccessRule($rule)
#Add Systemaccount
$rule = New-Object System.Security.AccessControl.FileSystemAccessRule(System,FullControl, ContainerInherit, ObjectInherit, None, Allow)
$acl.AddAccessRule($rule)
Set-Acl $UserHome $acl
$acl.AddAccessRule($rule)
	}
}
#endregion

#--------------------Hide or Unhide Textbox Password Computer -----------

#region Hide or Unhide Textbox 
function PasswordBox()
{
	if($objRadioButtonNoPW.Checked){
	$objTextboxAdmPW.Enabled = $false
	}else{
	$objTextboxAdmPW.Enabled = $false
	}
}

function ComputerBox()
{
	if($objRadioButtonNoComp.Checked){
	$objTextBoxComp.Enabled = $false
	}else{
	$objTextBoxComp.Enabled = $true
	}
}
#endregion



#---------------------Funtction Close Window---------------------
#region Funtction Close Window
function CloseForm()
{
	# Only Close Form
	$objForm.Close()
}
#endregion
#---------------------Funtction Clear Boxes Window---------------------
#region  Clear Boxes
function ClearBoxes ()
{
	$objRadioButtonWS.Checked = $WsActive
	$objRadioButtonSrv.Checked = $SrvActive
	$objRadioButtonYesPW.Checked = $true
	$objTextboxAdmPW.Text = $Password
	$objTextBoxComp.Text = $CompName
	$objFolderPathTextBox.Text = DUser.csv # (Get-Location).tostring()
	PasswordBox

}
#endregion
#---------------------Funtction CheckPrerequisits (Create User Change Password Change Computername---------------------
function CheckPrerequisits (){

	$Path2Check = $objFolderPathTextBox.get_Text().ToString()
 	if(Test-Path $Path2Check -Include .csv){ $PathCheck =$false}else{$PathCheck =$True}
	Write-Host $PathCheck 
	if($objRadioButtonYesPW.Checked -or $objRadioButtonYesComp.Checked -or $PathCheck ) 
		{	
			$MsgText = 
			if($objTextboxAdmPW.get_TextLength()-clt 8)
			{
				$MsgText = Ein Passwort muss gröser gleich 8 Zeichen sein, muss Sonderzeichen und Zahlen enthalten.`n
				$objTextboxAdmPW.ForeColor = Red
			}
			
			if($objTextBoxComp.get_Text().Equals($envCOMPUTERNAME))
			{
				$MsgText = $MsgText + Computername darf nicht gleich aktueller Name sein`n
					$objTextBoxComp.ForeColor = Red

			}
			if((test-path $objFolderPathTextBox.get_text() -Include .csv) -ne 'True' )
			{
				$MsgText = $MsgText + Gültie Datei Auswählen (CSV). `n
					$objFolderPathTextBox.ForeColor = Red

			}
			 
			if ($MsgText.Length -ne 0){
			[System.Windows.Forms.MessageBox]Show($MsgText,check config,OK,Warning)
			#Stops untill all Warings are solved Programm
			return Out-Null
			}
			
			
			
		}
		
#region Import User form File
Try
{
$cont = Import-Csv -Path $objFolderPathTextBox.get_Text().ToString() -Delimiter ;
}catch{
	[System.Windows.Forms.MessageBox]Show($Error[0].Exception.Message)
	return Out-Null
}
#endregion
$ProgValue = [Math]Round($objProgBar.get_maximum()$cont.Length)
$objProgBar.Maximum = ($ProgValue$cont.Length)
foreach ($line in $cont){
if($objRadioButtonSrv.Checked){
CreateUser -user $line
CreatePubShare
CreateUserhome -user $line

if($objRadioButtonYesPW.Checked){ResetAdminPW -Passwd $objTextboxAdmPW.get_text()}

if($objRadioButtonYesComp.Checked){RenameComputer -Name $objTextBoxComp.get_text()}
}else{
CreateUser -user $line
ResetAdminPW -Passwd $objTextboxAdmPW.get_text()

if($objRadioButtonYesPW.Checked){ResetAdminPW -Passwd $objTextboxAdmPW.get_text()}

if($objRadioButtonYesComp.Checked){RenameComputer -Name $objTextBoxComp.get_text()}

}

$objProgBar.Value += $ProgValue
}

succesfulycreatetd	
}


function succesfulycreatetd()
{
			if($objRadioButtonYesComp.Checked){	
            
            $MsgText = Änderungen erfolgreich ausgeführt.`nRechner wird nach dem bästätigen des OK Buttons neu gestartet
                }
			else{  $MsgText = Änderungen erfolgreich ausgeführt
}
			
			$result = New-object System.Windows.Forms.DialogResult
			$result = [System.Windows.Forms.MessageBox]Show($MsgText,Succesful,OKCancel,Info)
			if($result -eq OK -and $objRadioButtonYesComp.Checked)
			{ClearBoxes
             Restart-Computer
        	}
			else{ CloseForm }
			
}
#---------------------Create Main Window---------------------

#region Create Main Window
$objForm = New-Object System.Windows.Forms.Form
$SystemDrawingSize = New-Object System.Drawing.Size
$SystemDrawingSize.Height = 580
$SystemDrawingSize.Width = 400
$objForm.Text=Modul 127
$objForm.Size = $SystemDrawingSize
$objForm.StartPosition = CenterScreen
$objForm.FormBorderStyle= 'FixedDialog'
#endregion
#---------------------Create Window OS Selector---------------------
#region Window OS Selector
$objObjecSelectorGroupbox = New-Object System.Windows.Forms.GroupBox
$objObjecSelectorGroupbox.Text = Select Windows OS
$objObjecSelectorGroupbox.Enabled = $true
$SystemDrawingPoint = new-object System.Drawing.Point
$SystemDrawingPoint.X = 10
$SystemDrawingPoint.Y = 10
$objObjecSelectorGroupbox.Location = $SystemDrawingPoint
$SystemDrawingSize.Height = 60
$SystemDrawingSize.Width = 360
$objObjecSelectorGroupbox.Size = $SystemDrawingSize

#---------------------Create Radio Buttons Workstation Server---------------------
$objRadioButtonWS= New-Object System.Windows.Forms.RadioButton
$objRadioButtonWS.Text = 'Workstation'
$SystemDrawingPoint.X = 10
$SystemDrawingPoint.Y = 20
$objRadioButtonWS.Location = $SystemDrawingPoint
$SystemDrawingSize.Height = 25
$SystemDrawingSize.Width = 90
$objRadioButtonWS.Size = $SystemDrawingSize
$objRadioButtonWS.Checked = $WsActive
$objObjecSelectorGroupbox.Controls.Add($objRadioButtonWS)

$objRadioButtonSrv= New-Object System.Windows.Forms.RadioButton
$objRadioButtonSrV.Text = 'Server'
$SystemDrawingPoint.X = 250
$SystemDrawingPoint.Y = 20
$objRadioButtonSrV.Location = $SystemDrawingPoint
$SystemDrawingSize.Height = 25
$SystemDrawingSize.Width = 90
$objRadioButtonSrV.Size = $SystemDrawingSize
$objRadioButtonSrv.Checked = $SrvActive
$objObjecSelectorGroupbox.Controls.Add($objRadioButtonSrV)
#endregion

#---------------------Create Window Reset Admin Password ---------------------
#region Create Window Reset Admin Password
$objObjecSelectorGroupboxAdm = New-Object System.Windows.Forms.GroupBox
$objObjecSelectorGroupboxAdm.Text = Reset Aministrator Password
$objObjecSelectorGroupboxAdm.Enabled = $true
$SystemDrawingPoint.X = 10
$SystemDrawingPoint.Y = 90
$objObjecSelectorGroupboxAdm.Location = $SystemDrawingPoint
$SystemDrawingSize.Height = 110
$SystemDrawingSize.Width = 360
$objObjecSelectorGroupboxAdm.Size = $SystemDrawingSize

#---------------------Create Radio Buttons Password Yes  No ---------------------
$objRadioButtonYesPW= New-Object System.Windows.Forms.RadioButton
$objRadioButtonYesPW.Text = 'Yes'
$SystemDrawingPoint.X = 10
$SystemDrawingPoint.Y = 20
$objRadioButtonYesPW.Location = $SystemDrawingPoint
$SystemDrawingSize.Height = 35
$SystemDrawingSize.Width = 80
$objRadioButtonYesPW.Size = $SystemDrawingSize
$objRadioButtonYesPW.Checked = $true
$objRadioButtonYesPW.add_Click({PasswordBox})
$objObjecSelectorGroupboxAdm.Controls.Add($objRadioButtonYesPW)

$objRadioButtonNoPW= New-Object System.Windows.Forms.RadioButton
$objRadioButtonNoPW.Text = 'No'
$SystemDrawingPoint.X = 250
$SystemDrawingPoint.Y = 20
$objRadioButtonNoPW.Location = $SystemDrawingPoint
$SystemDrawingSize.Height = 35
$SystemDrawingSize.Width = 80
$objRadioButtonNoPW.Size = $SystemDrawingSize
$objRadioButtonNoPW.Checked = $false
$objRadioButtonNoPW.add_Click({PasswordBox})
$objObjecSelectorGroupboxAdm.Controls.Add($objRadioButtonNoPW)

#---------------------Create Textbox Admin PW ---------------------
$objTextboxAdmPW= New-Object System.Windows.Forms.MaskedTextBox
$objTextboxAdmPW.Text = $Password
$objTextboxAdmPW.Visible = $false
$SystemDrawingPoint.X = 10
$SystemDrawingPoint.Y = 70
$objTextboxAdmPW.Location = $SystemDrawingPoint
$SystemDrawingSize.Height = 100
$SystemDrawingSize.Width = 340
$objTextboxAdmPW.Size = $SystemDrawingSize
$objObjecSelectorGroupboxAdm.Controls.Add($objTextboxAdmPW)
#endregion

#---------------------Create change Computer Name ---------------------
#region Main Window change Computer Name
$objGroupboxComp = New-Object System.Windows.Forms.GroupBox
$objGroupboxComp.Text = Change Computername
$objGroupboxComp.Enabled = $true
$SystemDrawingPoint.X = 10
$SystemDrawingPoint.Y = 220
$objGroupboxComp.Location = $SystemDrawingPoint
$SystemDrawingSize.Height = 110
$SystemDrawingSize.Width = 360
$objGroupboxComp.Size = $SystemDrawingSize
#---------------------Create Radio CompName Buttons Yes  No ---------------------
$objRadioButtonYesComp= New-Object System.Windows.Forms.RadioButton
$objRadioButtonYesComp.Text = 'Yes'
$SystemDrawingPoint.X = 10
$SystemDrawingPoint.Y = 20
$objRadioButtonYesComp.Location = $SystemDrawingPoint
$SystemDrawingSize.Height = 35
$SystemDrawingSize.Width = 80
$objRadioButtonYesComp.Size = $SystemDrawingSize
$objRadioButtonYesComp.Checked = $true
$objRadioButtonYesComp.add_Click({ComputerBox})
$objGroupboxComp.Controls.Add($objRadioButtonYesComp)

$objRadioButtonNoComp= New-Object System.Windows.Forms.RadioButton
$objRadioButtonNoComp.Text = 'No'
$SystemDrawingPoint.X = 250
$SystemDrawingPoint.Y = 20
$objRadioButtonNoComp.Location = $SystemDrawingPoint
$SystemDrawingSize.Height = 35
$SystemDrawingSize.Width = 80
$objRadioButtonNoComp.Size = $SystemDrawingSize
$objRadioButtonNoComp.Checked = $false
$objRadioButtonNoComp.add_Click({ComputerBox})
$objGroupboxComp.Controls.Add($objRadioButtonNoComp)

#---------------------Create Path Folder Selector Textbox ---------------------
$objTextBoxComp = New-Object System.Windows.Forms.TextBox 
$objTextBoxComp.Text = $CompName
$SystemDrawingPoint.X = 10
$SystemDrawingPoint.Y = 70
$objTextBoxComp.Location = $SystemDrawingPoint
$SystemDrawingSize.Height = 150
$SystemDrawingSize.Width = 340
$objTextBoxComp.Size = $SystemDrawingSize
$objGroupboxComp.Controls.Add($objTextBoxComp) 
#endregion

#---------------------Create Main Window file selector---------------------
#region Main Window file selector
$objFolderGroupbox = New-Object System.Windows.Forms.GroupBox
$objFolderGroupbox.Text = Path to user creation file
$objFolderGroupbox.Enabled = $true
$SystemDrawingPoint.X = 10
$SystemDrawingPoint.Y = 350
$objFolderGroupbox.Location = $SystemDrawingPoint
$SystemDrawingSize.Height = 100
$SystemDrawingSize.Width = 360
$objFolderGroupbox.Size = $SystemDrawingSize

#---------------------Create Path Folder Selector Textbox ---------------------
$objFolderPathTextBox= New-Object System.Windows.Forms.TextBox
$objFolderPathTextBox.Text = DUser.csv #(Get-Location).tostring()
$SystemDrawingPoint.X = 10
$SystemDrawingPoint.Y = 40
$objFolderPathTextBox.Location = $SystemDrawingPoint
$SystemDrawingSize.Height = 150
$SystemDrawingSize.Width = 260
$objFolderPathTextBox.Size = $SystemDrawingSize
$objFolderGroupbox.Controls.Add($objFolderPathTextBox)
$Path = $objFolderPathTextBox.Text
#---------------------Create Path Folder Selector OpenDialog---------------------
$objFolderPathButton= New-Object System.Windows.Forms.Button
$objFolderPathButton.Text = Select file
$SystemDrawingPoint.X = 280
$SystemDrawingPoint.Y = 40
$objFolderPathButton.Location = $SystemDrawingPoint
$SystemDrawingSize.Height = 22
$SystemDrawingSize.Width = 70
$objFolderPathButton.Size = $SystemDrawingSize
$objFolderPathButton.add_Click({ShowDialog})
$objFolderGroupbox.Controls.Add($objFolderPathButton)
#endregion

#---------------------Create Apply, Reset & Calcel Button---------------------
#region Main Window Buttons
$objButtonCreate= New-Object System.Windows.Forms.Button
$objButtonCreate.Text = Create
$objButtonCreate.Enabled = $true
$SystemDrawingPoint.X = 70
$SystemDrawingPoint.Y = 520
$objButtonCreate.Location = $SystemDrawingPoint
$objButtonCreate.add_Click({CheckPrerequisits})

$objButtonReset= New-Object System.Windows.Forms.Button
$objButtonReset.Text = Reset
$objButtonReset.add_Click({ClearBoxes})
$SystemDrawingPoint.X = 160
$SystemDrawingPoint.Y = 520
$objButtonReset.Location = $SystemDrawingPoint

$objButtonClose= New-Object System.Windows.Forms.Button
$objButtonClose.Text = Close
$objButtonClose.add_Click({CloseForm})
$SystemDrawingPoint.X = 250
$SystemDrawingPoint.Y = 520
$objButtonClose.Location = $SystemDrawingPoint

#---------------------Create Progressbar Main Window ---------------------
#region
$objProgBar = New-Object System.Windows.Forms.ProgressBar
$objProgBar.Maximum = 100
$objProgBar.Minimum = 0
$objProgBar.Location = new-object System.Drawing.Size(10,460)
$objProgBar.size = new-object System.Drawing.Size(360,20)
$i = 0
$timer = New-Object System.Windows.Forms.Timer 
$timer.Interval = 1000
#endregion
#---------------------Construct Main Window ---------------------
$objForm.Controls.Add($objObjecSelectorGroupbox)
$objForm.Controls.Add($objObjecSelectorGroupboxAdm)
$objForm.Controls.Add($objGroupboxComp)
$objForm.Controls.Add($objFolderGroupbox)
$objForm.Controls.Add($objProgBar)
$objForm.Controls.Add($objButtonClose)
$objForm.Controls.Add($objButtonReset)
$objForm.Controls.Add($objButtonCreate)
#---------------------Start window Window---------------------

#--------------------Dialog form for File Select---------------------
#region Select file Dialog

function ShowDialog(){
	$objFolderPathTextBox.ForeColor = Black
	$objPathSelectorDialogResult = New-Object System.Windows.Forms.OpenFileDialog
	$objPathSelectorDialogResult.InitialDirectory = Get-Location
	$objPathSelectorDialogResult.Filter = CSV Files.csv;
	$objPathSelectorDialogResult.ShowDialog()
	$objFolderPathTextBox.Text= $objPathSelectorDialogResult.Filename
	}
#endregion

$Tooltip = New-Object System.Windows.Forms.ToolTip
$Tooltip.AutomaticDelay= 0
$Tooltip.ToolTipIcon=info
$Tooltip.ToolTipTitle=Info
$Tooltip.SetToolTip($objButtonCreate, Scritp kann ausgeführt werden)
$Tooltip.SetToolTip($objButtonReset, Setzt alle Felder auf den Anfangswert)
$Tooltip.SetToolTip($objButtonClose, Dialog wird geschlossen)

if(!(Test-Administrator)){

    $objForm.Text=Modul 127 Führen Sie das Script als Admin aus
    $objButtonCreate.Enabled = $false
    $Tooltip.SetToolTip($objButtonCreate, Scritp kann nur als Administrator ausgeführt werden)
    
    $MsgText = Scritp kann nur als Administrator ausgeführt werden	
			$result = New-object System.Windows.Forms.DialogResult
			$result = [System.Windows.Forms.MessageBox]Show($MsgText,Modul 127 Achtung,OKCancel,Error)
			if($result -eq OK -and $objRadioButtonYesComp.Checked)
			{return $MsgText
             
        	}
			else{ return $MsgText }
  

}


[void] $objForm.ShowDialog()