@echo off
:: create a amazn-linux-2 vm like "e:\06-vmware-machines\amzn-linux-2\amzn-linux-2.vmx"
:: above will be your base clone
:: create folder like "e:\06-vmware-machines\zombie-clones\"
:: add vmrun, vmware.bat to path

::set values locally and remove after execution
SetLocal

::check if args is empty
if [%1] equ [] goto help
goto %1

:help
    echo Available commands are:
    echo.
    echo clone       machines to clone single, multiple based on input
    echo start       start vm with given name
    echo help        command to execute
    goto :eof

:clone
    echo Enter the clone list in below format
    echo example: vm-01 vm-02 vm-03
    set /P list01=
    set /P prompt="Are you sure (Y/[N])? "
    if /I "%prompt%" NEQ "Y" goto eof
    (for %%a in (%list01%) do (
        echo %%a is cloned ...
        vmrun.exe -T ws clone e:\06-vmware-machines\amzn-linux-2\amzn-linux-2.vmx e:\06-vmware-machines\zombie-clones\%%a\%%a.vmx -cloneName="%%a" full
    ))
    ::
    goto :start

:start
    echo Enter machine names or leave blank to start all created now :
    echo.
    set /P list02=
    if [%list02%] equ [] (goto startall) else (goto startspecific)
    goto :eof

:startall
    set /P prompt="Are you sure (Y/[N])? "
    if /I "%prompt%" NEQ "Y" goto eof
    (for %%a in (%list01%) do (
        echo %%a is powering on ...
        vmrun.exe start e:\06-vmware-machines\zombie-clones\%%a\%%a.vmx nogui
    ))
    goto :eof

:startspecific
    set /P prompt="Are you sure (Y/[N])? "
    if /I "%prompt%" NEQ "Y" goto eof
    (for %%a in (%list02%) do (
        echo %%a is powering on ...
        vmrun.exe start e:\06-vmware-machines\zombie-clones\%%a\%%a.vmx
    ))
    goto :eof

:eof
    pause

EndLocal
