
git submodule update --init --recursive


cd Dependencies

rd /s /q vcpkg 2>nul
rd /s /q vcpkg_for_nf 2>nul

git clone https://github.com/ketoo/vcpkg_for_nf.git
if exist vcpkg_for_nf (
rename vcpkg_for_nf vcpkg
)
cd vcpkg


if exist installed\x64-windows-static\debug\lib\libprotobufd.zip (
7z.exe x installed\x64-windows-static\debug\lib\libprotobufd.zip -oinstalled\x64-windows-static\debug\lib\
)
if exist installed\x64-windows-static\lib\libprotobuf.rar (
7z.exe x installed\x64-windows-static\lib\libprotobuf.rar -oinstalled\x64-windows-static\lib\
)

cd ..

xcopy vcpkg\installed\x64-windows-static\lib lib\Release\ /s /e /Y
xcopy vcpkg\installed\x64-windows-static\bin ..\_Out\Release\  /s /e /Y

xcopy vcpkg\installed\x64-windows-static\debug\lib lib\Debug\  /s /e /Y
xcopy vcpkg\installed\x64-windows-static\debug\bin ..\_Out\Debug\  /s /e /Y



xcopy vcpkg\installed\x64-windows-static\tools\protobuf\protoc.exe ..\NFComm\NFMessageDefine\ /s /e /Y




cd ..
