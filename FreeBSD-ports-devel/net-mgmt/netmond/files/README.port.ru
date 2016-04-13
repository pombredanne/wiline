
    	    netmond-2.2-b6-port

� ������ ��������� ������� ��������� � ����������  ������������ 
������������ �������� �������� netmond-2.2-b6.

##################################################################

SrcAddress patch

##################################################################
 � ��������� ��������� ���������� ���� ������ IP �����
��������� ��� �������, ������������ �� ������������ ����
� ������, ���� ������ ����� ��������� ����������� �\��� 
�������.

��������:

- ����� ����������� ����������� ����� �� ������������ ��������,
  �� ������������ � ��������� �� ��������� ��� ����� �����.
  
- ��������� ���� ����� ����� "�������" ������������������ 
  �������� ������, ���, ��� ��������� �� ������ ������ �
  ������������ IP �������.
  
- �� �������� �� ���������� ����� ���������� �������, ��� 
  ������ � ������������ IP ������� ����� ���������, ��� 
  ������ ����� ��� ������ ���������� (����) �������.  
  
��������� ��������� "SrcAddress"

  � ���������� ��������� ��� ��������� ������ IP ����� ���������
��� ���� ��������, ��� ������� IP ����� ��������� ���� �� �����.
���� ��������� �� ������� - ���� ����� = 0.0.0.0

  � ��������� �������, ��� ��������� ������ IP ����� ��������� ���
������� ����� ������� �� ���� ����.

���� ��������� ����� �� ������� - ������ ����� ���� ���, ��� ��
���������� �����.

������:

    SrcAddress "192.168.2.1"

    Object "somehost" {
	Address "192.168.1.2"
	SrcAddress "192.168.1.1"
	....................
    }

����������:

  �� ����������� ��������������� �������� ���������� IP ������ 
��������� ��� ������ ����� ������������. ��� ������, ��� �� 
������� ������� ������ �� ���� �� �� �������, ��� ����������� 
������� IP ����� ���������. 
  IP ����� ��������� ���������� ������ � NetState �������. 

##################################################################

UID-GID-ChRoot Patch

##################################################################

  ���� ������ ����� ���������� PIPE ��� FILE, ��, � ��������� 
�������, ����������� �������� �������, �������� ���������� ������.
  ������ "Netmod" �������� �� ����� ������������ "root".
������������� �������� �������� ���-�� ����������� �� ����� 
"root". ������ ������, ��� �����������, ��� �����, ��� ���
���������� ���� �������� ������ ����� "root" �� �����.

 ��������� ���������� ��������� "UserName" "GroupName" "ChrootDir"
���� ������� ��� ���������, �� ����� �������� ��������� ��������,
( ����� fork, �� ������ exec ) �������� chroot � ��������� �������
(���� ������� �� ������ - �� ��������), � ���������� GID,UID ��������.

�� ���������, chroot �� ��������, UserName = netmon, GroupName= netmon.

������:
    UserName   "nobody"
    GroupName  "nogroup"
    ChRootDir  "/var/netmon"

�������, �� ������ ���� �������, ��� ������� ����� ��������� �� "root".

##################################################################

NetState BindAddress Patch

##################################################################

 ������ ������ ������ ���� �������� IP �����, �� ������� NetState 
������ ������� ��������� TCP ����������. 

��������� ��������� "BindAddress" � ��������� "Port".

������:
    Port 3333 {
	    BindAddress	"192.168.1.1"
	    ............
    }
���

NetState {
    Port 3333
    BindAddress "192.168.1.1"
}


�� ���������, ���� ��������� TCP ���������� �� ���� ��������� �������.

##################################################################

Trap Patch

##################################################################

 ������ ������ ������ ���� �������� IP �����, �� �������  
������ ������� �������� SNMP Trap.

��������� ��������� "TrapBindAddress" � ���������� ���������.

������:
    TrapBindAddress	"192.168.1.1"

�� ���������, ���� �������� SNMP Trap �� ���� ��������� �������.

##################################################################


PID-���� ������ ������������ � /var/run/netmond.pid


##################################################################

��������� ����������� ������������ � ���������� ���������� NetState
������� �����.

##################################################################

Object multiple states

##################################################################

������ ������ ����� ���� � ���������� ����������: UP DEGRADED WARNING DOWN NONE
(������ ���� UP DOWN NONE). ��������� DOWN ��������, ��� ��� ������ ������
������� ����������� ��������. ��������� DEGRADED ��������, ��� ���������
������ ������ ������� ����������� ��������, �� ��������� - ����������� ���������.
��������� WARNING ��������, ��� ���� �������� � �����-�� ����������� �������� -
���� ���������, ���� ������, ���� BGP peer ��� ENVMON ��������� � ���������,
�������� �� UP (NORMAL,ESTABLISHED).

##################################################################

Method WHEN

##################################################################

���������� ������ ���������� WHEN, ����� ���������� ���������� 
���������, ������ ������ ���������� � ��������. ���� ���������� 
��������� ����� ����������� ��� TRUE, � ����� � ���� ��������� � �������
������� �������, �� ����� ����� ����� ����� ����������� �������,
� �������� ���������� OBJECT!methodname ����� ����� ����������� 
������ ����������. ������ �������� � ��������� DEGRADED.
������:
    Method "CPU_alarm" {
	When "$LoadAve > 20" 300 "Attention! LoadAve too much! ($LoadAve)"
    }

���������� ������ - ������ ��������� ������� � ������ ���������� ��������� 
�������� ������������������ - �������� CPU, LoadAve, ��������� ������,
�������� ������������ � ����.

��������! �������� ������������ ���������� ������ ���� �������� ��� ������
          ������ ������� ������.

##################################################################

Method PIPE

##################################################################

���������� ������ ���. ������ ������ ����� �� ��������� ����� 
����������� ��� ��������� ������� ����������� ��������.
��� ���� ����� ������������ CHAT ������, ��� ��� ������ TCP.
� ����� ������ ���������, ��������� ��������� �� STDIN, �
��������� ���������� ������ ���� ������� � STDOUT.
��������� ���������� ������ ����������, � ������� ���������� �����.
����� ����, ����� �������� �������� ��������������� ����������
��������� OBJECT_NAME, OBJECT_ADDRESS, �, ���� ���� ���������� � 
������������, �� OBJECT_SRC_ADDRESS, OBJECT_DATADIR.
     ..................... 
     Method "CheckSSL" {
        Pipe "/usr/local/bin/check_ssl.pl" 
	Timeout 3
	ChatScript { 
	    Expect "verify"
	    Send "GET /\n\r\n\r"
	    Expect "<HTML>" 
	}
     }
     ................
/usr/local/bin/check_ssl.pl:
    #!/usr/bin/perl
    #
    $addr = $ENV{"OBJECT_ADDRESS"};                                               
    if ($ARGV[0] ) {                                                              
	$port = $ARGV[0];                                                         
    } else  {                                                                     
        $port ="443";                                                             
    }                                                                             
    $SIG{TERM} = sub {
	close PRGR;
	close PRGW;
	close STDIN;
	close STDOUT;
	kill $main::pid;
	exit(0);
    };
    use FileHandle;                                                               
    use IPC::Open2;                                                               
    $main::pid=open2(PRGR,PRGW,"/usr/bin/openssl s_client -quiet -ssl3 -connect $addr:$port");      
    $_=<STDIN>;      
    print PRGW $_;
    while  (<PRGR>){                                                              
	print STDOUT $_;                                                                 
    }                                                                             
    close STDOUT;                                                                 
    exit 0;                                                                       
    
������ ��� �������������� ������ ���� ������� ������� ���������.
����� ������ �����������, � �������� ������ ��������� ���������� 
������ SIGKILL ��� ��������������� ����������.
 ����� ������������ ��� ������ ����������������� ������� 
��������, ������� ���������� �������� ������� TCP, � ���
����������� ������������ RSH ��� ������ ����������� ������� 
� ��������� ���������� �� ��������� �����. 
 ������� ��������� ����������� � ������� ������������ � �������, 
������������ � ���������� UserName GroupName. ���� ���������� ��������� 
�hRootDir, �� ����� �������� �������������� CHROOT � ���� �������.

##################################################################

������������� ����������� �� �������� ������� ����������.
������ ������ ����� ���� �� INT_MAX.
������ ��� ������ �������� MS Windows ����� ������������ ���������:

    Interface 65539 { }
    
    �������  ������� ��������� <kropachev(sobaka)rdu.kirov.ru>.
##################################################################

���������������� ���� �� ��������� - /usr/local/etc/netmond.conf

