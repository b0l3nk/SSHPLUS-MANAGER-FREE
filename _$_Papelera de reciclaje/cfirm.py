#!/usr/bin/env python
# encoding: utf-8
import smtplib,socket,sys
from os import system
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from datetime import datetime
_NOME_ = sys.argv[1]
_IP_ = sys.argv[2]
_ADRESS_OS_ = '/etc/issue.net'
OS = open(_ADRESS_OS_).readlines()
for SYS in OS:
	_OS_ = SYS.replace('\n','')
_DATA_ = datetime.now()
_ANO_ = str(_DATA_.year)
_MES_ = str(_DATA_.month)
_DIA_ = str(_DATA_.day)
_HORA_ = str(_DATA_.hour)
_MINUTO_ = str(_DATA_.minute)
_SEGUNDO_ = str(_DATA_.second)
_MSG_ = MIMEMultipart('alternative')
_MSG_['Subject'] = "INSTALASI SSHPLUS"
_MSG_['From'] = 'crzvpn@gmail.com'
_MSG_['To'] = 'crzvpn@gmail.com'
_TEXTO_ = """\
<html>
<head></head>
<body>
<b><i>Halo! Crazy</i></b>
<br></b>
<b><i>SKRIP ANDA TELAH DIINSTAL PADA VPS<i></b>
<br></br>
<b><p>══════════════════════════</p><b><i>INFORMASI INSTALASI<i></b>
<br><b><font color="blue">IP:</b> </font><i><b><font color="red">""" + _IP_ + """</font></b></i>
<br><b><font color="blue">Nama: </b></font> <i><b><font color="red">""" + _NOME_ + """</font></b></i>
<br><b><font color="blue">Sistem: </b></font> <i><b><font color="red">""" + _OS_ + """</font></b></i>
<b><p>══════════════════════════</p><b><i>DATA DA INSTALASI<i></b>
<br><b><font color="blue">Hari: </b></font> <i><b><font color="red">"""+_DIA_+"""</font></b></i>
<br><b><font color="blue">Bulan: </b></font> <i><b><font color="red">"""+_MES_+"""</font></b></i>
<br><b><font color="blue">Tahun: </b></font> <i><b><font color="red">"""+_ANO_+"""</font></b></i>
<b><p>══════════════════════════</p><b/>
<b><i>HORA DA INSTALASI<i>
<br><b><font color="blue">Jam: </b></font><i> <b><font color="red">""" + _HORA_ +"""</font></b></i>
<br><b><font color="blue">menit: </b></font> <i><b><font color="red">""" + _MINUTO_ + """</font></b></i>
<br><b><font color="blue">detik: </b></font> <i><b><font color="red">""" + _SEGUNDO_ + """</font></b></i>
<b><p>══════════════════════════</p><b><b><i><font color="#00FF00">By: crazy</i></b></br></p>
</body>
</html>
"""
_MSG2_ = MIMEText(_TEXTO_, 'html')
_MSG_.attach(_MSG2_)
_SERVER_ = smtplib.SMTP('smtp.gmail.com',587)
_SERVER_.ehlo()
_SERVER_.starttls()
_SERVER_.login('ga6055602@gmail.com','gustavo123!')
_SERVER_.sendmail('ga6055602@gmail.com','crzvpn@gmail.com',_MSG_.as_string())
