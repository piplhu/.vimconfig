@PowerShell -ExecutionPolicy Bypass -Command Invoke-Expression $('$args=@(^&{$args} %*);'+[String]::Join(';',(Get-Content '%~f0') -notmatch '^^@PowerShell.*EOF$')) & goto :EOF

Push-Location ~

$repo_path   = "$HOME\.vimconfig"

Function Pause ($Message = "�밴���ⰴ������ . . . ") {
  if ((Test-Path variable:psISE) -and $psISE) {
    $Shell = New-Object -ComObject "WScript.Shell"
      $Button = $Shell.Popup("Click OK to continue.", 0, "Script Paused", 0)
  } else {     
    Write-Host -NoNewline $Message
      [void][System.Console]::ReadKey($true)
      Write-Host
  }
}

echo "==> ��ʼ��⻷������..."
echo ""
sleep 1


echo "==> ���� git ����"
if (Get-Command "git" -ErrorAction SilentlyContinue) {
  git version
  echo "[OK] ���Գɹ�. ��ʼ��һ������..."
  sleep 1
} else {
  echo ""
  echo "[ERROR] �޷������ PATH �з��� 'git.exe' ����"
  echo ">>> ׼���˳�......"
  Pause
  exit
}

echo ""

echo "==> ���� vim ����"
if (Get-Command "vim" -ErrorAction SilentlyContinue) {
  echo ($(vim --version) -split '\n')[0]
  echo "[OK] ���Գɹ�. ��ʼ��һ������..."
  sleep 1
} else {
  echo "[WARNING] �޷������ PATH �з��� 'vim' ����. ���Կɼ�����װ..."
  echo ""
  echo "[WARNING] �������װ vim ������ȷ������� PATH! "
  Pause
}

echo "==> ���� nvim ����"
if (Get-Command "nvim" -ErrorAction SilentlyContinue) {
  echo ($(nvim --version) -split '\n')[0]
  echo "[OK] ���Գɹ�. ��ʼ��һ������..."
  sleep 1
} else {
  echo "[WARNING] �޷������ PATH �з��� 'nvim' ����. ���Կɼ�����װ..."
  echo ""
  echo "[WARNING] �������װ Neovim ������ȷ������� PATH! "
  Pause
}

echo "<== ����������������. ������һ��..."
sleep 1
echo ""
echo ""

echo ""
if (!(Test-Path "$HOME\vimfiles")) {
  cmd /c mklink $HOME\vimfiles $repo_path
  echo "[OK] ��Ϊ vim ��װ"
  sleep 1
} else {
  echo "[OK] $HOME\vimfiles �Ѵ���"
  sleep 1
}

echo ""
if (!(Test-Path "$HOME\AppData\Local\nvim")) {
  cmd /c mklink "$HOME\AppData\Local\nvim" $repo_path
  echo "[OK] ��Ϊ neovim ��װ"
  sleep 1
} else {
  echo "[OK] $HOME\AppData\Local\nvim �Ѵ���"
  sleep 1
}

Pause

