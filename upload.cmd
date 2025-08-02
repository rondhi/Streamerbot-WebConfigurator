setlocal

:: Get current branch name
for /f %%i in ('git rev-parse --abbrev-ref HEAD 2^>nul') do set "branch=%%i"
IF "%branch%"=="main" (
  SET subpath=webconfig
) ELSE (
  SET subpath=webconfig-%branch%
)

aws s3 sync --acl public-read  . s3://whazzittoya.com/%subpath% --exclude * --include *.js --include *.css --include *.html --include *.gif --include *.jpg --include *.png --include *.svg --include *.wav --include *.json --exclude package.json --exclude filtrex/* --include  filtrex/src/*.js --dryrun
