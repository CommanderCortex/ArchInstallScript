#/bin/bash
cd friends
cp ~/Music/song1.mp3 ~/Music/song2.mp3 ~/Pictures/snap1.jpg ~/Pictures/snap2.jpg ~/Videos/film1.avi ~/Videos/film2.avi

ls -l

cd ../family
cp ~/Music/song3.mp3 ~/Music/song4.mp3 ~/Pictures/snap3.jpg ~/Pictures/snap4.jpg ~/Videos/film3.avi ~/Videos/film4.avi

ls -l

cd ../work
cp -r ~/family ~/friends
ls -l
cd ..
rm -r family friends work
ls -l
exit

