all: espeak-data/en_dict espeak-data/ja_dict

espeak-data/phontab: espeak-data/phsource/ph_japanese espeak-data/phsource/phonemes.append espeak-data/voices/ja espeak-data/voices/mb/mb-jp1
	rsync -aCv espeak/espeak-data/ ${HOME}/espeak-data/
	rsync -aCv espeak/phsource/ ${HOME}/espeak-data/phsource/
	cp espeak-data/phsource/ph_japanese ${HOME}/espeak-data/phsource/
	cp espeak-data/voices/ja ${HOME}/espeak-data/voices/
	cp espeak-data/voices/mb/mb-jp1 ${HOME}/espeak-data/voices/mb/
	cp espeak-data/voices/mb/mb-jp2 ${HOME}/espeak-data/voices/mb/
	cp espeak-data/voices/mb/mb-jp3 ${HOME}/espeak-data/voices/mb/
	cat espeak-data/phsource/phonemes.append >> ${HOME}/espeak-data/phsource/phonemes
	espeakedit --compile
	cp ${HOME}/espeak-data/phontab espeak-data/
	cp ${HOME}/espeak-data/phonindex espeak-data/
	cp ${HOME}/espeak-data/phondata espeak-data/
	cp ${HOME}/espeak-data/intonations espeak-data/

# cannot compile mbrola phoneme translation data from command line
#espeak-data/mbrola_ph/jp_phtrans:
#	cp espeak-data/phsource/mbrola/jp1 ${HOME}/espeak-data/phsource/mbrola/
#	cp espeak-data/phsource/mbrola/jp2 ${HOME}/espeak-data/phsource/mbrola/
#	cp espeak-data/phsource/mbrola/jp3 ${HOME}/espeak-data/phsource/mbrola/
#	espeakedit
#	if [ ! -d espeak-data/mbrola_ph/ ]; then mkdir -p espeak-data/mbrola_ph/; fi
#	cp ${HOME}/espeak-data/mbrola/jp1_phtrans espeak-data/mbrola/
#	cp ${HOME}/espeak-data/mbrola/jp2_phtrans espeak-data/mbrola/
#	cp ${HOME}/espeak-data/mbrola/jp3_phtrans espeak-data/mbrola/

espeak-data/en_dict: espeak-data/phontab
	cd espeak/dictsource/; espeak --compile=en
	cp ${HOME}/espeak-data/en_dict espeak-data/

espeak-data/ja_dict: espeak-data/phontab espeak-data/dictsource/ja_list espeak-data/dictsource/ja_rules
	cd espeak-data/dictsource/; espeak --compile=ja --path=../..
	cp espeak-data/ja_dict ${HOME}/espeak-data/

speak:
	espeak -v ja -X --path=. '我々 は 宇宙人 だ'

clean:
	rm -R espeak-data/phontab espeak-data/phonindex espeak-data/phondata
	rm -R espeak-data/en_dict espeak-data/ja_dict
	rm espeak-data/dictsource/ja_list

