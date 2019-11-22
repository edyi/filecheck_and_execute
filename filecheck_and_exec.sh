#!/usr/bin/env bash

#比較する対象のファイルがあるURL(github)と仮のファイル名
d_url="https://raw.githubusercontent.com/edyi/git_install/master/git_install.sh"
file1="tmp.file1"
file2="tmp.file2"

#ファイルに更新があった場合の処理を書く
function execute () {
    echo "do something"
}

#(初回のみの処理)ファイルがなかった場合だけダウンロードする
if [ ! -e ./$file1 ]; then
    curl -o ./$file1 -O -s $d_url 
    #初回の場合は比較する必要がないのでexitする
    exit 0
else
    #ファイルがある場合はgithubのファイルを別名で保存する
    curl -o ./$file2 -O -s $d_url 
fi

#保存してあるファイルとgithubからダウンロードしたファイルを比較する
diff -q $file1 $file2
#差分があったらファイルが更新されたということなのでfile1で保存しておく
if [ "$?" = 1 ]; then
    curl -o ./$file1 -O -s $d_url
    #何か処理する
    execute
else
   #差分がない場合はそのまま終了する
   echo "no changed"
   exit 0
fi
