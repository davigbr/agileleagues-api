node_modules/.bin/mocha server/app/test --recursive -R progress --compilers coffee:coffee-script/register
node_modules/.bin/mocha dist/app/test --recursive -R html-cov -r blanket --compilers coffee:coffee-script/register > coverage.html
