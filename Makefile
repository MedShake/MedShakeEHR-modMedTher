default:
	rm -f MedShakeEHR-modMedTherm.zip SHA256SUMS
	zip -r MedShakeEHR-modMedTherm.zip . -x .git\* -x Makefile -x installer\*
	sha256sum -b MedShakeEHR-modMedTherm.zip > preSHA256SUMS
	head -c 64 preSHA256SUMS > SHA256SUMS
	rm -f preSHA256SUMS

clean:
	rm -f MedShakeEHR-modMedTherm.zip