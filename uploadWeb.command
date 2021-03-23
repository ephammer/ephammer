cd /Users/kid0n/StudioProjects/portofolio_page
flutter build web
cp -R /Users/kid0n/StudioProjects/portofolio_page/build/web/* /Users/kid0n/StudioProjects/ephammer.github.io/
cd ~/StudioProjects/ephammer.github.io/
git add /Users/kid0n/StudioProjects/ephammer.github.io/*
git commit -m "Portfolio"
git push -u origin master