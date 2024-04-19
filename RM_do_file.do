//import data
import excel "C:\Users\glk22nhj\OneDrive - Bangor University\RM\selected\data excel\Book_FINAL.xlsx", sheet("Results") firstrow
//change to lowercase
ren *,lower
//rename variables names
rename operatingrevenueturnoverme operatingrevenueturnoverme2021
rename d operatingrevenueturnoverme2020
rename e operatingrevenueturnoverme2019
rename f operatingrevenueturnoverme2018
rename g operatingrevenueturnoverme2017
rename h operatingrevenueturnoverme2016
rename i operatingrevenueturnoverme2015
rename j operatingrevenueturnoverme2014
rename roeusingplbeforetax202 roeusingplbeforetax2021
rename l roeusingplbeforetax2020
rename roeusingplbeforetax201 roeusingplbeforetax2019
rename n roeusingplbeforetax2018
rename o roeusingplbeforetax2017
rename p roeusingplbeforetax2016
rename q roeusingplbeforetax2015
rename r roeusingplbeforetax2014
rename plforperiodnetincomeme plforperiodnetincomeme2021
rename ar plforperiodnetincomeme2020
rename as plforperiodnetincomeme2019
rename at plforperiodnetincomeme2018
rename au plforperiodnetincomeme2017
rename av plforperiodnetincomeme2016
rename aw plforperiodnetincomeme2015
rename ax plforperiodnetincomeme2014
//reshape long data to wide
reshape long operatingrevenueturnoverme roeusingplbeforetax totalassetsmeur numberofemployees shareholdersfundsmeur plforperiodnetincomeme, i(bvdidnumber) j(year)
//generate equity
gen equ= plforperiodnetincomeme/ roeusingplbeforetax
//generate leverage
gen lev = totalassetsmeur/ equ
qnorm totalassetsmeur
qnorm numberofemployees
qnorm shareholdersfundsmeur
qnorm operatingrevenueturnoverme
qnorm equ
qnorm lev
gen tass=log(totalassetsmeur)
gen num=log(numberofemployees)
gen shf=log(shareholdersfundsmeur)
gen tur=log(operatingrevenueturnoverme)
gen eq=log(equ)
gen lv=log(lev)
qnorm tass
qnorm num
qnorm shf
qnorm tur
qnorm eq
qnorm lv
tabstat tass,statistics(q iqr p90)
gen size=1 
replace size=0 if tass<3.963488
pwcorr roeusingplbeforetax num shf tur eq lv size
pwcorr roeusingplbeforetax  tur  lv size
regress roeusingplbeforetax  tur  lv size

