startproject () {
	mkproject $1;
	reload\!;
	pip install Django;
	django-admin.py startproject --template==$TEMPLATE_PATH $1;
	cd $1;
	pip install -r requirements.txt;
}