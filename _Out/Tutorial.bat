cd /d %~dp0
cd Debug

echo Starting NFTutorialServer...
start "NFTutorialServer" "NFServer.exe" "Server=GameServer" "ID=16002" "Plugin=Tutorial.xml"