#!/bin/bash

ROLE=$1;
HOST=$2;

validate_keytabfile_rm_nn_function()
{
if [ ! -f /apache/hadoop/keytabs/$HOST/rm.keytab -o ! -f /apache/hadoop/keytabs/$HOST/nn.keytab ];then
	if [ ! -d /apache/hadoop/keytabs/$HOST ];then
                mkdir -p /apache/hadoop/keytabs/$HOST;
	else
		echo "No Keytabs present for $HOST creating new;";
	fi
else
	echo "Keytab file exists for $HOST ; Remove it and will generate new ";
	exit;
fi	
}

validate_keytabfile_jhs_function()
{
if [ ! -f /apache/hadoop/keytabs/$HOST/jhs.keytab ];then
        if [ ! -d /apache/hadoop/keytabs/$HOST ];then
                mkdir -p /apache/hadoop/keytabs/$HOST;
        else
                echo "No Keytabs present for $HOST creating new;";
        fi
else
        echo "Keytab file exists for $HOST ; Remove it and will generate new ";
        exit;
fi
}

validate_keytabfile_nm_dn_function()
{
if [ ! -f /apache/hadoop/keytabs/$HOST/dn.keytab -o ! -f /apache/hadoop/keytabs/$HOST/nm.keytab ];then
        if [ ! -d /apache/hadoop/keytabs/$HOST ];then
                mkdir -p /apache/hadoop/keytabs/$HOST;
        else
                echo "No Keytabs present for $HOST creating new;";
        fi
else
        echo "Keytab file exists for $HOST ; Remove it and will generate new ";
        exit;
fi
}

validate_keytabfile_qj_function()
{
if [ ! -f /apache/hadoop/keytabs/$HOST/qj.keytab ];then
        if [ ! -d /apache/hadoop/keytabs/$HOST ];then
                mkdir -p /apache/hadoop/keytabs/$HOST;
        else
                echo "No Keytabs present for $HOST creating new;";
        fi
else
        echo "Keytab file exists for $HOST ; Remove it and will generate new ";
        exit;
fi
}


case $ROLE in

nn)
	validate_keytabfile_rm_nn_function;
	/usr/bin/kadmin -p createkeytab/admin  -k -t /apache/hadoop/keytabs/createkeytab.keytab -q "addprinc -randkey nn/$HOST";
	/usr/bin/kadmin -p createkeytab/admin  -k -t /apache/hadoop/keytabs/createkeytab.keytab -q "addprinc -randkey host/$HOST";
	/usr/bin/kadmin -p createkeytab/admin  -k -t /apache/hadoop/keytabs/createkeytab.keytab -q "addprinc -randkey HTTP/$HOST";
	/usr/bin/kadmin -p createkeytab/admin  -k -t /apache/hadoop/keytabs/createkeytab.keytab -q "ktadd -k /apache/hadoop/keytabs/$HOST/nn.keytab nn/$HOST host/$HOST";
	/usr/bin/kadmin -p createkeytab/admin  -k -t /apache/hadoop/keytabs/createkeytab.keytab -q "ktadd -k /apache/hadoop/keytabs/$HOST/http.keytab HTTP/$HO
ST";
        chown hdfs:hadoop /apache/hadoop/keytabs/$HOST/http.keytab;
        chmod 400 /apache/hadoop/keytabs/$HOST/http.keytab;
	chown hdfs:hadoop /apache/hadoop/keytabs/$HOST/nn.keytab;
	chmod 400 /apache/hadoop/keytabs/$HOST/nn.keytab;;

rm)
	validate_keytabfile_rm_nn_function;
        /usr/bin/kadmin -p createkeytab/admin  -k -t /apache/hadoop/keytabs/createkeytab.keytab -q "addprinc -randkey rm/$HOST";
        /usr/bin/kadmin -p createkeytab/admin  -k -t /apache/hadoop/keytabs/createkeytab.keytab -q "addprinc -randkey host/$HOST";
	/usr/bin/kadmin -p createkeytab/admin  -k -t /apache/hadoop/keytabs/createkeytab.keytab -q "addprinc -randkey HTTP/$HOST";
        /usr/bin/kadmin -p createkeytab/admin  -k -t /apache/hadoop/keytabs/createkeytab.keytab -q "ktadd -k /apache/hadoop/keytabs/$HOST/rm.keytab rm/$HOST host/$HOST"; /usr/bin/kadmin -p createkeytab/admin  -k -t /apache/hadoop/keytabs/createkeytab.keytab -q "ktadd -k /apache/hadoop/keytabs/$HOST/http.keytab HTTP/$HOST"; chown hdfs:hadoop /apache/hadoop/keytabs/$HOST/http.keytab; chmod 400 /apache/hadoop/keytabs/$HOST/http.keytab; chown yarn:hadoop /apache/hadoop/keytabs/$HOST/rm.keytab; chmod 400 /apache/hadoop/keytabs/$HOST/rm.keytab;; 
dn)
	validate_keytabfile_nm_dn_function;	
	/usr/bin/kadmin -p createkeytab/admin  -k -t /apache/hadoop/keytabs/createkeytab.keytab -q "addprinc -randkey hdfs/$HOST";
	/usr/bin/kadmin -p createkeytab/admin  -k -t /apache/hadoop/keytabs/createkeytab.keytab -q "addprinc -randkey host/$HOST";
	/usr/bin/kadmin -p createkeytab/admin  -k -t /apache/hadoop/keytabs/createkeytab.keytab -q "addprinc -randkey http/$HOST";
	/usr/bin/kadmin -p createkeytab/admin  -k -t /apache/hadoop/keytabs/createkeytab.keytab -q "addprinc -randkey yarn/$HOST";
	/usr/bin/kadmin -p createkeytab/admin  -k -t /apache/hadoop/keytabs/createkeytab.keytab -q "addprinc -randkey mapred/$HOST";
	/usr/bin/kadmin -p createkeytab/admin  -k -t /apache/hadoop/keytabs/createkeytab.keytab -q "ktadd -k /apache/hadoop/keytabs/$HOST/hdfs.keytab hdfs/$HOST host/$HOST http/$HOST";
        /usr/bin/kadmin -p createkeytab/admin  -k -t /apache/hadoop/keytabs/createkeytab.keytab -q "ktadd -k /apache/hadoop/keytabs/$HOST/mapred.keytab mapred/$HOST host/$HOST";
	/usr/bin/kadmin -p createkeytab/admin  -k -t /apache/hadoop/keytabs/createkeytab.keytab -q "ktadd -k /apache/hadoop/keytabs/$HOST/yarn.keytab yarn/$HOST host/$HOST";
        chown hdfs:hadoop /apache/hadoop/keytabs/$HOST/hdfs.keytab;
	chown mapred:hadoop /apache/hadoop/keytabs/$HOST/mapred.keytab;
	chmod 400 /apache/hadoop/keytabs/$HOST/mapred.keytab;
        chmod 400 /apache/hadoop/keytabs/$HOST/hdfs.keytab;
	chown yarn:hadoop /apache/hadoop/keytabs/$HOST/yarn.keytab;
        chmod 400 /apache/hadoop/keytabs/$HOST/yarn.keytab;;

jhs)
	validate_keytabfile_jhs_function;
	/usr/bin/kadmin -p createkeytab/admin  -k -t /apache/hadoop/keytabs/createkeytab.keytab -q "addprinc -randkey mapred/$HOST";
	/usr/bin/kadmin -p createkeytab/admin  -k -t /apache/hadoop/keytabs/createkeytab.keytab -q "addprinc -randkey HTTP/$HOST";
        /usr/bin/kadmin -p createkeytab/admin  -k -t /apache/hadoop/keytabs/createkeytab.keytab -q "ktadd -k /apache/hadoop/keytabs/$HOST/jhs.keytab mapred/$HOST host/$HOST";
	/usr/bin/kadmin -p createkeytab/admin  -k -t /apache/hadoop/keytabs/createkeytab.keytab -q "ktadd -k /apache/hadoop/keytabs/$HOST/http.keytab HTTP/$HOST";
	chown mapred:hadoop /apache/hadoop/keytabs/$HOST/jhs.keytab;
        chmod 400 /apache/hadoop/keytabs/$HOST/jhs.keytab;
	chown hdfs:hadoop /apache/hadoop/keytabs/$HOST/http.keytab;
	chmod 400 /apache/hadoop/keytabs/$HOST/http.keytab;;

qj)
        validate_keytabfile_qj_function;
        /usr/bin/kadmin -p createkeytab/admin  -k -t /apache/hadoop/keytabs/createkeytab.keytab -q "addprinc -randkey qj/$HOST";
	/usr/bin/kadmin -p createkeytab/admin  -k -t /apache/hadoop/keytabs/createkeytab.keytab -q "addprinc -randkey host/$HOST";
	/usr/bin/kadmin -p createkeytab/admin  -k -t /apache/hadoop/keytabs/createkeytab.keytab -q "addprinc -randkey HTTP/$HOST";
        /usr/bin/kadmin -p createkeytab/admin  -k -t /apache/hadoop/keytabs/createkeytab.keytab -q "ktadd -k /apache/hadoop/keytabs/$HOST/qj.keytab qj/$HOST host/$HOST";
	/usr/bin/kadmin -p createkeytab/admin  -k -t /apache/hadoop/keytabs/createkeytab.keytab -q "ktadd -k /apache/hadoop/keytabs/$HOST/http.keytab HTTP/$HOST";
        chown hdfs:hadoop /apache/hadoop/keytabs/$HOST/qj.keytab /apache/hadoop/keytabs/$HOST/http.keytab;
        chmod 400 /apache/hadoop/keytabs/$HOST/qj.keytab /apache/hadoop/keytabs/$HOST/http.keytab;;

*)
	echo "Error : Not a valid parameter passed";
	echo "Run with following 'createkeytabs.sh qj/dn/rm/nn/jhs hostname'";;

esac

