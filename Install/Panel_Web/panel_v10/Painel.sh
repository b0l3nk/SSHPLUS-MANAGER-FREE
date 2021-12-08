clear
IP=$(wget -qO- ipv4.icanhazip.com)
echo "America/Mexico_City" > /etc/timezone
ln -fs /usr/share/zoneinfo/America/Mexico_City /etc/localtime > /dev/null 2>&1
dpkg-reconfigure --frontend noninteractive tzdata > /dev/null 2>&1
clear
echo -e "\E[44;1;37m           PANEL SSHPLUS WEB v10           \E[0m"
echo ""
echo -e "                \033[1;31m"
echo ""
echo -e "\033[1;32mSELALU LAPORAN PASSWORD YANG SAMA"
echo -e "\033[1;32mSELALU KONFIRMASI PERTANYAAN DENGAN \033[1;37m Y"
echo ""
echo -e "\033[1;36mMULAI INSTALASI"
echo ""
echo -e "\033[1;33mTUNGGU..."
apt-get update > /dev/null 2>&1
echo ""
echo -e "\033[1;36mMENGINSTAL APACHE2\033[0m"
echo ""
echo -e "\033[1;33mTUNGGU..."
apt-get install apache2 -y > /dev/null 2>&1
sed -i "s;Listen 80;Listen 81;g" /etc/apache2/ports.conf
service apache2 restart > /dev/null 2>&1
apt-get install cron curl unzip -y > /dev/null 2>&1
echo ""
echo -e "\033[1;36mMENGINSTAL KEPERCAYAAN\033[0m"
echo ""
echo -e "\033[1;33mTUNGGU..."
apt-get install php5 libapache2-mod-php5 php5-mcrypt -y > /dev/null 2>&1
service apache2 restart 
echo ""
echo -e "\033[1;36mMENGINSTAL MySQL\033[0m"
echo ""
sleep 1
apt-get install mysql-server -y 
echo ""
clear
echo -e "                \033[1;31mPERHATIAN"
echo ""
echo -e "\033[1;32mSELALU LAPORAN LULUS YANG SAMA SETIAP YANG DIMINTA"
echo -e "\033[1;32mSELALU KONFIRMASI PERTANYAAN DENGAN  \033[1;37m Y"
echo ""
echo -ne "\033[1;33mEnter, Untuk melanjutkan!\033[1;37m"; read
mysql_install_db
mysql_secure_installation
clear
echo -e "\033[1;36mMENGINSTAL PHPMYADMIN\033[0m"
echo ""
echo -e "\033[1;31mPERHATIAN \033[1;33m!!!"
echo ""
echo -e "\033[1;32mPILIH OPSI \033[1;31mAPACHE2 \033[1;32mDENGAN KUNCI '\033[1;33mENTER\033[1;32m'"
echo ""
echo -e "\033[1;32mPILIH \033[1;31mYES\033[1;32m DI OPSI BERIKUTNYA (\033[1;36mdbconfig-common\033[1;32m)"
echo -e "UNTUK MENGONFIGURASI DATABASE"
echo ""
echo -e "\033[1;32mSELALU MASUKKAN PASSWORD YANG SAMA"
echo ""
echo -ne "\033[1;33mEnter, Untuk melanjutkan!\033[1;37m"; read
apt-get install phpmyadmin -y
php5enmod mcrypt
service apache2 restart
ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin
apt-get install libssh2-1-dev libssh2-php -y > /dev/null 2>&1
apt-get install php5-curl > /dev/null 2>&1
service apache2 restart
clear
echo ""
echo -e "\033[1;31mPERHATIAN \033[1;33m!!!"
echo ""
echo -ne "\033[1;32mMASUKKAN PASSWORD YANG SAMA\033[1;37m: "; read senha
echo -e "\033[1;32mOK\033[1;37m"
sleep 1
mysql -h localhost -u root -p$senha -e "MEMBUAT DATABASE plus"
clear
echo -e "\033[1;36mSELESAI INSTALASI\033[0m"
echo ""
echo -e "\033[1;33mMEMEGANG..."
echo ""
mkdir /var/www/html
cd /var/www/html
wget https://www.dropbox.com/s/g6bt89bounzpwyo/painel10.zip > /dev/null 2>&1
sleep 1
unzip painel10.zip > /dev/null 2>&1
rm -rf painel10.zip index.html > /dev/null 2>&1
service apache2 restart
sleep 1
if [[ -e "/var/www/html/pages/system/pass.php" ]]; then
sed -i "s;suasenha;$senha;g" /var/www/html/pages/system/pass.php > /dev/null 2>&1
fi
sleep 1
cd
wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Panel_Web/panel_v10/plus.sql > /dev/null 2>&1
sleep 1
if [[ -e "$HOME/plus.sql" ]]; then
    mysql -h localhost -u root -p$senha --default_character_set utf8 plus < plus.sql
    rm /root/plus.sql
else
    clear
    echo -e "\033[1;31mKESALAHAN SAAT MENGIMPOR DATABASE\033[0m"
    sleep 2
    exit
fi
echo '* * * * * root /usr/bin/php /var/www/html/pages/system/cron.php' >> /etc/crontab
echo '* * * * * root /usr/bin/php /var/www/html/pages/system/cron.ssh.php ' >> /etc/crontab
echo '* * * * * root /usr/bin/php /var/www/html/pages/system/cron.sms.php' >> /etc/crontab
echo '* * * * * root /usr/bin/php /var/www/html/pages/system/cron.online.ssh.php' >> /etc/crontab
echo '10 * * * * root /usr/bin/php /var/www/html/pages/system/cron.servidor.php' >> /etc/crontab
/etc/init.d/cron reload > /dev/null 2>&1
/etc/init.d/cron restart > /dev/null 2>&1
chmod 777 /var/www/html/admin/pages/servidor/ovpn
chmod 777 /var/www/html/admin/pages/download
chmod 777 /var/www/html/admin/pages/faturas/comprovantes
service apache2 restart
sleep 1
clear
echo -e "\033[1;32mPANEL BERHASIL DIPASANG!"
echo ""
echo -e "\033[1;36mLINK WILAYAH ADMINISTRASI:\033[1;37m $IP:81/admin\033[0m"
echo -e "\033[1;36mLINK AREA RESELLER: \033[1;37m $IP:81\033[0m"
echo -e "\033[1;36mNAMA PENGGUNA\033[1;37m admin\033[0m"
echo -e "\033[1;36mKATA SANDI\033[1;37m admin\033[0m"
echo ""
echo -e "\033[1;36mMASUKKAN LINK INI PADA VPS YANG AKAN MENJADI SERVER\033[0m"
echo -e "\033[1;37mwget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Panel_Web/panel_v10/revenda/confpainel/inst && bash inst\033[0m"
echo -e "\033[1;33mUbah kata sandi setelah memasuki panel\033[0m"
cat /dev/null > ~/.bash_history && history -c