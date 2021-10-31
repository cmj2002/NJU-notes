for DIR in `ls | grep "/$" `
do
    cd $DIR
    echo $(pwd)
    npm install mathjax@2.7.7
    npm install gitbook-plugin-mathjax-pro
    gitbook install
    cd ../
done
read -n 1