# extract */wall/* files naming them with a-b, where a is the first * and b the last * equivalent

DESTINATION="~/.wallpapers/auto/"

for i in $(find . -type f -name "wall*"); do
	cp $i ~/.wallpapers/auto/$(echo $i | awk -F '/' '{print $2 $4}')
done
