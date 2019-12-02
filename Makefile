default:
	zip -r MedShakeEHR-modMedTherm.zip . -x .git\* -x Makefile

clean:
	rm -f MedShakeEHR-modMedTherm.zip
