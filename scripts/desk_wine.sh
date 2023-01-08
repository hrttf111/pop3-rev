case $1 in
    1)
        echo "Enable desktop mode"
        regedit /C "export.reg"
        ;;
    export)
        echo "Export desktop config"
        regedit /E "export2.reg" "HKEY_CURRENT_USER\Software\Wine\Explorer"
        ;;
    *)
        echo "Disable desktop mode"
        regedit /D "HKEY_CURRENT_USER\Software\Wine\Explorer"
        regedit -C "export1.reg"
        #regedit /D "HKEY_CURRENT_USER\Software\Wine\Explorer\Desktops"
        #regedit /D "HKEY_CURRENT_USER\Software\Wine\Explorer"
        #regedit /D "HKEY_CURRENT_USER\Software\Wine\Explorer\Desktops\Default"
        #regedit /D "HKEY_CURRENT_USER\Software\Wine\Explorer\Desktop"
        ;;
esac
