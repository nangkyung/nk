libname raw "D:\★낭파일\★학교연구\★연구실데이터\건보표본데이터1.0";
libname use "D:\★낭파일\★학교연구\★연구실데이터\건보표본데이터1.0\통합";
libname keep "C:\Users\user\Desktop\학교연구\이주상교수님수업\데이터정리";


/*
전체당뇨환자 정의

=>E11.0~E14.9의 당뇨병 상병명으로 청구되고, 당뇨병 약제를 2회 이상 처방받은 경우 
2005년 1월 1일부터 2014년 12월 31일까지 2번 이상 청구한 경우 당뇨병 환자로 정의

=> E10~E14
 
(6,468,187)
*/
DATA keep.dm;
SET use.t40_id;
where 'E10'<=substr(SICK_SYM,1,3)<='E14';
RUN;
proc sort data=keep.dm out=dm_du nodupkey;/*전체적으로 대략적인 수치 확인(237,310)*/
by person_id;
run;

/*---------------------------------------------------------------------------------------------------*/
/*---------------------------------------------------------------------------------------------------*/
/*---------------------------------------------------------------------------------------------------*/
/*---------------------------------------------------------------------------------------------------*/


/*
1. 2002년부터 2015년까지의 자료 중 한국표준질병사인분류코드에 제시된 상병명 코드 E11 (제2형 당뇨병)이 청구된 환자추출
2.당뇨병 약제의 주성분 코드로 청구된 이력이 있고 최초청구일 기준 나이가 30세 이상인 환자
*/


/*1. 2002년부터 2015년까지의 자료 중 한국표준질병사인분류코드에 제시된 상병명 코드 E11 (제2형 당뇨병)이 청구된 환자추출*/
data keep.dm2;/*5,025,639*/
set keep.dm;
where substr(SICK_SYM,1,3) in ('E11');
run;
proc sort data=keep.dm2 out=dm2_du ;/*187,890*/
by person_id RECU_FR_DT;
run;
proc sort data=dm2_du out=keep.dm2_du nodupkey;/*187,890*/
by person_id;
run;


/*2.당뇨병 약제의 주성분 코드로 청구된 이력이 있고 최초청구일 기준 나이가 30세 이상인 환자*/
DATA keep.dm_drug_60;/*약제 내용 추출(6,146,191)*/
SET use.t60;
where GNL_NM_CD in ('100601ATB',	'100602ATB',	'165402ATB',	'165602ATB',	'165603ATR',	'165604ATR',	'165701ATB',	'165702ATB',	'165703ATB',	'165704ATB',	'165801ATB',	'191501ATB',	'191502ATB',	'191502ATR',	'191503ATB',	'191503ATR',	'191504ATB',	'191504ATR',	'191505ATR',	'249001ATB',	'249002ATB',	'379501ATB',	'379502ATB',	'379503ATB',	'430201ATB',	'430202ATB',	'430203ATB',	'431901ATB',	'431902ATB',	'443400ATB',	'443400ATB',	'443500ATB',	'443500ATB',	'474200ATB',	'474200ATB',	'474300ATB',	'474300ATB',	'474300ATR',	'474300ATR',	'498600ATB',	'498600ATB',	'486101ATB',	'497200ATB',	'497200ATB',	'498100ATB',	'498100ATB',	'500801ATB',	'501101ATB',	'501102ATB',	'501103ATB',	'502300ATB',	'502300ATB',	'502300ATR',	'502300ATR',	'502900ATB',	'502900ATB',	'513700ATB',	'513700ATB',	'513700ATR',	'513700ATR',	'524700ATR',	'524700ATR',	'507000ATB',	'507000ATB',	'507100ATB',	'507100ATB',	'519600ATB',	'519600ATB',	'518500ATR',	'518500ATR',	'518600ATR',	'518600ATR',	'518800ATB',	'518800ATB',	'520500ATB',	'520500ATB',	'520600ATB',	'520600ATB',	'520700ATB',	'520700ATB',	'523800ATR',	'523800ATR',	'632000ATR',	'632000ATR',	'645000ATR',	'645000ATR',	'654100ATR',	'654100ATR',	'525500ATB',	'525500ATB',	'525600ATB',	'525600ATB',	'525901ATB',	'527302ATB',	'613301ATB',	'613302ATB',	'616401ATB',	'619101ATB',	'624202ATB',	'624203ATB',	'627301ATB',	'628201ATB',	'628202ATB',	'630500ATB',	'630500ATB',	'630600ATB',	'630600ATB',	'635600ATB',	'635600ATB',	'635700ATB',	'635700ATB',	'675500ATB',	'675500ATB',	'636101ATB',	'639601ATB',	'639800ATR',	'639800ATR',	'641400ATR',	'641400ATR',	'641800ATR',	'641800ATR',	'641900ATR',	'641900ATR',	'642000ATR',	'642000ATR',	'645301ATB',	'648400ATB',	'648400ATB',	'648500ATB',	'648500ATB',	'648600ATB',	'648600ATB',	'649000ATB',	'649000ATB',	'649100ATB',	'649100ATB',	'649200ATB',	'649200ATB',	'649300ATB',	'649300ATB',	'649400ATB',	'649400ATB',	'649500ATB',	'649500ATB',	'649900ATR',	'649900ATR',	'650000ATR',	'650000ATR',	'650100ATR',	'650100ATR',	'653800ATR',	'653800ATR',	'653900ATR',	'653900ATR',	'654000ATR',	'654000ATR',	'655700ATR',	'655700ATR',	'664600ATB',	'664600ATB',	'664700ATB',	'664700ATB',	'664800ATB',	'664800ATB',	'671800ATR',	'671800ATR',	'673800ATR',	'673800ATR',	'671900ATR',	'671900ATR',	'672000ATR',	'672000ATR',	'672100ATR',	'672100ATR',	'672500ATR',	'672500ATR',	'672600ATR',	'672600ATR',	'672700ATR',	'672700ATR',	'672800ATR',	'672800ATR',	'672900ATR',	'672900ATR',	'683300ATR',	'683300ATR',	'683400ATR',	'683400ATR',	'674301ATB',	'674302ATB',	'685801ATB',	'701201ATB',	'702500ATB',	'702500ATB',	'702600ATB',	'702600ATB',	'702700ATB',	'702700ATB',	'704100ATB',	'704100ATB',	'704200ATB',	'704200ATB',	'704300ATB',	'704300ATB',	'170130BIJ',	'170131BIJ',	'170430BIJ',	'170431BIJ',	'175330BIJ',	'175331BIJ',	'175332BIJ',	'175333BIJ',	'441330BIJ',	'441331BIJ',	'441332BIJ',	'441333BIJ',	'461830BIJ',	'461831BIJ',	'461832BIJ',	'484930BIJ',	'484931BIJ',	'488730BIJ',	'626700BIJ',	'626700BIJ',	'626830BIJ',	'639701BIJ',	'639702BIJ',	'666700BIJ',	'666700BIJ',	'667000BIJ',	'667000BIJ',	'693900BIJ',	'693900BIJ');
RUN;
proc sql;
create table keep.dm_drug_60_id as
select distinct t2.person_id,t1.*
from keep.dm_drug_60 t1 left join use.t20 t2 on (t1.KEY_SEQ=t2.KEY_SEQ);
quit;
proc sort data=keep.dm_drug_60_id out=dm_drug_60_id nodupkey;/*76,629*/
by person_id;
run;


%macro load_data;
    data use.t30_0208;
        set 
            %do i=2002 %to 2008;
                raw.nhid_gy30_t1_&i 
                raw.nhid_gy30_t2_&i 
                raw.nhid_gy30_t3_&i
            %end;
        ;
    run;
%mend load_data;
%load_data;
%macro load_data;
    data use.t30_0913;
        set 
            %do i=2010 %to 2013;
                raw.nhid_gy30_t1_&i 
                raw.nhid_gy30_t2_&i 
                raw.nhid_gy30_t3_&i
            %end;
        ;
    run;
%mend load_data;
%load_data;

/*
t30에서는 주성분코드가 아닌 제품코드가 필요함

=1일투여량또는실시횟수(DD_MQTY_EXEC_FREQ)
=총투여일수또는실시횟수(MDCN_EXEC_FREQ)
=1회투약량(DD_MQTY_FREQ)
*/
%macro t30(dataset);
data keep.&dataset;
set use.&dataset(keep=KEY_SEQ SEQ_NO DIV_CD RECU_FR_DT DD_MQTY_EXEC_FREQ MDCN_EXEC_FREQ DD_MQTY_FREQ);
where DIV_CD in (
                        'A26800981',	'A26800991',	'A01202311',	'A07401221',	'A08850991',	'A00801961',	'A04703301',	'A06550011',	'A08401901',	'A11152521',	'A11850031',	'A12850341',	'A15253191',	'A17050131',	'A18752581',	'A18950022',	'A19650731',	'A20703201',	'A23053751',	'A23450061',	'A25850101',	'A34850271',	'A36750551',	'A60650041',	'A04705561',	'E06740051',	'A01207451',	'A01508221',	'A02507571',	'A04506701',	'A07150011',	'A07404051',	'A13302510',	'A15204791',	'A18401801',	'A21404151',	'A22452051',	'A23402941',	'A27804241',	'A44300931',	'A00306451',	'A00802981',	'A01207321',	'A01306491',	'A01402211',	'A01508201',	'A02004181',	'A02107581',	'A02304221',	'A03005931',	'A03404611',	'A03505091',	'A03602701',	'A03805581',	'A04304131',	'A04803301',	'A05404711',	'A05607431',	'A05705491',	'A06103421',	'A06502241',	'A06601881',	'A06703811',	'A06906681',	'A07208471',	'A07404061',	'A07704871',	'A08403441',	'A08504391',	'A08803401',	'A09003781',	'A09305601',	'A09505631',	'A09703991',	'A10003661',	'A10703581',	'A11103731',	'A11204101',	'A11303551',	'A11603351',	'A11801301',	'A12401141',	'A12603831',	'A12703351',	'A12804241',	'A12905351',	'A13102931',	'A15902271',	'A17001081',	'A17603891',	'A18701971',	'A18901901',	'A19203271',	'A19501901',	'A20403391',	'A20705081',	'A21101011',	'A21403931',	'A22502581',	'A23003911',	'A25005281',	'A25803201',	'A28302291',	'A30603771',	'A31804281',	'A32202571',	'A33003151',	'A33253571',	'A34800621',	'A35104221',	'A35504281',	'A36705421',	'A37002991',	'A37803501',	'A39605471',	'A42951551',	'A43900421',	'A45900431',	'A50703131',	'A57000231',	'A62700671',	'A66300481',	'A73400271',	'A78800061',	'A79152541',	'A79450041',	'A01508971',	'A11204221',	'A01508981',	'A03405101',	'A03652731',	'A04506731',	'A07404311',	'A11205031',	'A11604311',	'A12206661',	'A16604821',	'A21404511',	'A22458181',	'A22607441',	'A29506431',	'A04502851',	'A02054741',	'A04300461',	'A11252621',	'A17650091',	'A25050711',	'A00350841',	'A02054731',	'A03051671',	'A03450531',	'A03551591',	'A03600471',	'A04302371',	'A06551151',	'A06652501',	'A08450861',	'A09050401',	'A10750511',	'A11152871',	'A11252551',	'A11303141',	'A11850541',	'A12852051',	'A12902321',	'A13353601',	'A17602441',	'A18450421',	'A20752811',	'A21452541',	'A25050721',	'A25852721',	'A27852331',	'A36750541',	'A00205001',	'A01306871',	'A01508561',	'A02304811',	'A03006271',	'A03505491',	'A03602851',	'A04507601',	'A04803571',	'A05404961',	'A06103731',	'A06703991',	'A07404931',	'A07703520',	'A09003881',	'A09305911',	'A11255121',	'A17604091',	'A19902011',	'A21404381',	'A23004081',	'A32202711',	'A35104641',	'A35504891',	'E01620161',	'E31490031',	'A11252391',	'A16652701',	'A04350761',	'A11204001',	'W21620451',	'A03505761',	'A04506891',	'A11602741',	'A21407591',	'A00307211',	'A00702311',	'A01307181',	'A01402551',	'A03006211',	'A03505481',	'A04506671',	'A05706231',	'A07104801',	'A08404001',	'A08504951',	'A11602751',	'A12804831',	'A15204751',	'A16604861',	'A20705561',	'A21404351',	'A22607481',	'A31804781',	'A35104771',	'A62301121',	'A79450321',	'E08720211',	'E08720201',	'E08720191',	'A03404271',	'A00307221',	'A03006361',	'A03404281',	'A03505581',	'A04557851',	'A04804771',	'A06103881',	'A06502811',	'A06704091',	'A08404161',	'A12804801',	'A12909681',	'A13306011',	'A15204901',	'A16604811',	'A17001521',	'A20705511',	'A22402171',	'A23004371',	'A27804301',	'A31804691',	'A32202821',	'A35104741',	'A37003881',	'A60608171',	'A62704751',	'A78801491',	'A00307521',	'A03404721',	'A31805091',	'A00305005',	'A00702011',	'A00803111',	'A01208001',	'A01307041',	'A01453491',	'A01508791',	'A02108001',	'A02305003',	'A02705811',	'A03006351',	'A03405121',	'A03505002',	'A03602911',	'A03800021',	'A04204621',	'A04305481',	'A04507091',	'A04705721',	'A04804721',	'A05405002',	'A05705005',	'A06105007',	'A06502551',	'A06704071',	'A06907081',	'A07205001',	'A07705201',	'A08403931',	'A08504791',	'A08603441',	'A08803731',	'A09203741',	'A09505981',	'A10004201',	'A10704061',	'A10803301',	'A11104091',	'A11305004',	'A11604041',	'A11801441',	'A12058651',	'A12206801',	'A12604271',	'A12703581',	'A12804781',	'A13103101',	'A13306161',	'A13808111',	'A15204891',	'A15603661',	'A15902481',	'A16604801',	'A17001471',	'A17604101',	'A18251481',	'A18401901',	'A18703311',	'A19205005',	'A19902051',	'A20404241',	'A21404781',	'A22402141',	'A22503641',	'A22607291',	'A23004401',	'A23454541',	'A25804031',	'A27805002',	'A28302621',	'A29506381',	'A30608411',	'A31804601',	'A32202791',	'A33203461',	'A34003521',	'A34800781',	'A35104711',	'A35505031',	'A36706101',	'A37003841',	'A50601881',	'A60304171',	'A62301081',	'A62704691',	'A66303061',	'A78000271',	'A78801421',	'E00510331',	'A01209281',	'A04507671',	'A09306071',	'E00510341',	'A00253181',	'A01452951',	'A04854891',	'A05455781',	'A06154101',	'A06552761',	'A08653511',	'A11155181',	'A12256911',	'A12854921',	'A13356261',	'A15255081',	'A16255581',	'A16654951',	'A18250931',	'A19253901',	'A21455091',	'A22657651',	'A25854051',	'A27854381',	'A31854871',	'A44356831',	'A60658341',	'A62755011',	'A78050581',	'A82050861',	'E01620081',	'E03070041',	'A00253191',	'A01452961',	'A04854881',	'A05455791',	'A06154091',	'A06552751',	'A08653521',	'A11155191',	'A12256921',	'A12854931',	'A13356251',	'A15255071',	'A16255591',	'A16654961',	'A19253891',	'A21455101',	'A22657661',	'A25854101',	'A27854391',	'A31854881',	'A44356821',	'A60354421',	'A60658331',	'A62755021',	'A78050591',	'A82050851',	'E01620091',	'E03070051',	'A07404791',	'A07404801',	'A07404981',	'A02107801',	'A11205041',	'E00510661',	'A07404961',	'E01631651',	'E09060631',	'E09060611',	'E09060621',	'E09060661',	'E09060771'
                       );
run;
%mend;
%t30(t30_0208);
%t30(t30_0913);

data keep.dm_drug_30;
set keep.t30_0208 keep.t30_0913;
run;
proc sql;
create table keep.dm_drug_30_id as
select distinct t2.person_id,t1.*
from keep.dm_drug_30 t1 left join use.t20 t2 on (t1.KEY_SEQ=t2.KEY_SEQ);
quit;
proc sort data=keep.dm_drug_30_id out=dm_drug_30_id nodupkey;/*52,658*/
by person_id;
run;


/*당뇨병 약을 처방받은 이력이 있는사람 확인*/
proc sql;/*75,833=>66,535*/
create table keep.dm_drug_ox as
select distinct t1.*,
					(case when t1.person_id=t2.person_id then 1 else 0 end)as drug60,
					(case when t1.person_id=t3.person_id then 1 else 0 end)as drug30
from keep.dm2_du t1 left join dm_drug_60_id t2 on (t1.person_id=t2.person_id and t1.RECU_FR_DT<=t2.RECU_FR_DT)
					 		left join dm_drug_30_id t3 on (t1.person_id=t3.person_id and t1.RECU_FR_DT<=t3.RECU_FR_DT)
having drug60=1 or drug30=1;
quit;


/*최초진단일 시 30세 이상인 환자*/
proc sql;/*57,985*/
create table keep.dm_age as
select distinct t1.*,t2.AGE_GROUP
from keep.dm_drug_ox t1 left join use.jk t2 on (t1.person_id=t2.person_id 
																and substr(t1.RECU_FR_DT,1,4)=t2.STND_Y)
where t2.AGE_GROUP<='7';
quit;





/*---------------------------------------------------------------------------------------------------*/
/*
(WASH-OUT)

(1) 당뇨 최초 진단자를 포함하기 위해 2002년에서 2003년 사이에 제2형 당뇨병 상병명 코드 또는 당뇨병 약제가 청구된 과거 이력이 있는 자 
(2) 당뇨병 진단 2년 이내 합병증이 발생한 자
(3) 당뇨병 진단 이후 2년 이내에 사망한 자
(4) 제2형 당뇨병 진단년도 전 ? 후 1년 이내의 건강검진 이력이 없어 대상자 인구사회학적 특성 및 질병 관련 특성을 확인할 수 없는 자
(5) 검진 기록에 결측 자료가 있는 자
(6) 제1형 당뇨병 관련 상병명 코드(E10.x)가 한 번이라도 부여된 자
*/
/*---------------------------------------------------------------------------------------------------*/




/*
																					(stpe 1) 
당뇨 최초 진단자를 포함하기 위해 2002년에서 2003년 사이에 제2형 당뇨병 상병명 코드 또는 당뇨병 약제가 청구된 과거 이력이 있는 자
*/
/*2002년에서 2003년 사이에 제2형 당뇨병 상병명 코드*/
data patient_2002_3;/*23,577*/
set keep.dm_age;
where '2002'<=substr(RECU_FR_DT,1,4)<='2003';
run;
/*2002년에서 2003년 사이에 당뇨병 약제가 청구*/
%macro set(data);
data wash_&data(keep=person_id);
set keep.&data;
where '2002'<=substr(RECU_FR_DT,1,4)<='2003';
run;
%mend;
%set(dm_drug_30_id);
%set(dm_drug_60_id);
data wash_du_drug;
set wash_dm_drug_30_id wash_dm_drug_60_id;
run;
proc sort data=wash_du_drug out=wash_du_drug_use nodupkey;/*28,186*/
by person_id;
run;

/*(1)wash final*/
proc sql;/*39,150*/
create table keep.dm_sick as
select distinct t1.*
from keep.dm_age t1 left join patient_2002_3 t2 on (t1.person_id=t2.person_id)
							left join wash_du_drug_use t3 on (t1.person_id=t3.person_id)
where ((t1.person_id^=t2.person_id)or(t1.person_id^=t3.person_id));
quit;


/*
			      (step 2)
당뇨병 진단 2년 이내 합병증이 발생한 자
*/
/*합병증 전체 추출*/
data keep.complications;
set use.T40_ID;
where
		/*심혈관질환*/
		'I200'<=substr(SICK_SYM,1,4)<='I251'
		 or 'I253'<=substr(SICK_SYM,1,4)<='I259'
		 or 'I500'<=substr(SICK_SYM,1,4)<='I509'
		 or 'I700'<=substr(SICK_SYM,1,4)<='I719'

		 /*뇌혈관질환*/
		 or 'G450'<=substr(SICK_SYM,1,4)<='G459'
		 or 'I630'<=substr(SICK_SYM,1,4)<='I639'
		 or 'I650'<=substr(SICK_SYM,1,4)<='I669'

		 /*말초혈관질환*/
		 or substr(SICK_SYM,1,4) in ('E115','E135','E145','I738','I739','I771')
		 or 'I790'<=substr(SICK_SYM,1,4)<='I798'
		 or 'K551'<=substr(SICK_SYM,1,4)<='K559'
		 or 'Z958'<=substr(SICK_SYM,1,4)<='Z959'

		 /*눈질환*/
		 or substr(SICK_SYM,1,4) in ('E113','E133','E143','H540','H549')
		 or 'H330'<=substr(SICK_SYM,1,4)<='H368'
		 or 'H540'<=substr(SICK_SYM,1,4)<='H549'

		 /*신장질환*/
		 or substr(SICK_SYM,1,4) IN ('E112','E132','E142','N289')
		 or 'N030'<=substr(SICK_SYM,1,4)<='N039'
		 or 'N050'<=substr(SICK_SYM,1,4)<='N059'
		 or 'N170'<=substr(SICK_SYM,1,4)<='N179'
		 or 'N250'<=substr(SICK_SYM,1,4)<='N259'
		 or 'Z490'<=substr(SICK_SYM,1,4)<='Z492'
		 or substr(SICK_SYM,1,4) IN ('Z992')

		 /*신경병증*/
		 or substr(SICK_SYM,1,4) IN ('E114','E124','E134','E144','G538','G629','G632','G640')
		 or 'G560'<=substr(SICK_SYM,1,4)<='G598'
		 or 'G900'<=substr(SICK_SYM,1,4)<='G909'
		 or 'G990'<=substr(SICK_SYM,1,4)<='G998'

		 /*족부질환*/
		 or substr(SICK_SYM,1,3) IN ('L97','R02','S80','S81','S90','S91','T13','Z89')
;run;

/*index date기준으로 계산*/
proc sql;
create table keep.complications_index as
select distinct t1.person_id,T1.RECU_FR_DT,
					T2.RECU_FR_DT as index_date
from keep.complications t1 inner join keep.dm_sick t2 on (t1.person_id=t2.person_id)
order by t1.person_id,T1.RECU_FR_DT;
quit;
data keep.complications_2year;
set keep.complications_index;
where 1825>=intck('day',input(RECU_FR_DT,yymmdd8.),input(index_date,yymmdd8.))>=0;
run;
proc sort data=keep.complications_2year out=complications_2year nodupkey;/*21,257*/
by person_id;
run;

/*(2)wash final*/
proc sql;/*17,893*/
create table keep.dm_complications_2year_wash as
select distinct t1.*
from keep.dm_sick t1 left join complications_2year t2 on (t1.person_id=t2.person_id)
where t1.person_id^=t2.person_id;
quit;


/*
					(step 3)
당뇨병 진단 이후 2년 이내에 사망한 자
*/
data death;
set use.jk;
where DTH_YM is not null;
run;
proc sql;/*17,893*/
create table keep.dm_death as
select distinct t1.PERSON_ID,t1.RECU_FR_DT as index_date,t1.SICK_SYM,t1.AGE_GROUP,
					t2.DTH_YM
from keep.dm_complications_2year_wash t1 left join death t2 on (t1.person_id=t2.person_id)
order by t1.PERSON_ID;
quit;
data keep.death_2year;/*98*/
set keep.dm_death;
where 24>=intck('month',input(DTH_YM,yymm6.),input(index_date,yymm6.))>=0;
run;
/*(3)wash final*/
proc sql;/*17,795*/
create table keep.dm_death_2year_wash as
select distinct t1.*
from keep.dm_death t1 left join keep.death_2year t2 on (t1.person_id=t2.person_id)
where t1.person_id^=t2.person_id;
quit;




/*
(step 4)
제2형 당뇨병 진단년도 전 ? 후 1년 이내의 건강검진 이력이 없어 대상자 인구사회학적 특성 및 질병 관련 특성을 확인할 수 없는 자
DTH_YM*/

%macro load_data;

    /* 초기 데이터셋 생성 */
    data keep.dm_year_check;
        set keep.dm_death_2year_wash;
    run;

    %do i=2004 %to 2013;
        proc sql;
            create table keep.dm_year_check as
            select a.*,
                   (case when (a.person_id = b.person_id) then &i end) as gy_&i
            from keep.dm_year_check as a
            left join raw.NHID_GJ_&i as b
            on a.person_id = b.person_id;
        quit;
    %end;

%mend load_data;
%load_data;
data keep.dm_year_check_closest_year;
    set keep.dm_year_check;

    /* 날짜 변환 */
    format recu_date date9.;
    recu_date = input(index_date, yymmdd10.);

    /* 연도 변수 배열 선언 */
    array gy_vars gy_2004-gy_2013;
    closest_year = .; /* 가장 가까운 연도를 저장할 변수 */
    min_diff = .; /* 최소 차이를 저장할 변수 */

    /* 각 연도별 차이 계산 */
    do i = 2004 to 2013;
        if gy_vars[i-2003] ^= . then do;
            diff = abs(intck('year', recu_date, mdy(1, 1, i)));
            if (min_diff = . or diff < min_diff) and diff <= 1 then do;
                min_diff = diff;
                closest_year = i; /* 1년 이내에서 가장 가까운 연도 저장 */
            end;
        end;
    end;

    /* gy_2004 ~ gy_2013 변수 삭제 */
    drop gy_2004-gy_2013 recu_date min_diff diff i;
run;
data keep.dm_year_check_closest_year_fin;/*7,704*/
set keep.dm_year_check_closest_year;
where closest_year is not null;
run;

/*
				(step 5)
검진 기록에 결측 자료가 있는 자
*/
/* closest_year 변수 값에 따라 그룹별로 데이터 추출 */
proc sql noprint;
    select distinct closest_year into :year_list separated by ' '
    from keep.dm_year_check_closest_year
    where closest_year is not null; /* NULL 값 제외 */
quit;

%macro split_by_closest_year;

    /* 각 closest_year 값에 대해 데이터 추출 */
    %do i = 1 %to %sysfunc(countw(&year_list));
        %let year = %scan(&year_list, &i);

        data keep.closest_year_&year;
            set keep.dm_year_check_closest_year;
            where closest_year = &year; /* 현재 closest_year 그룹만 추출 */
        run;

    %end;

%mend split_by_closest_year;
%split_by_closest_year;

%macro rename_variable_2009_2013;

    /* 2009년부터 2013년까지 반복 처리 */
    %do year = 2009 %to 2013;

        /* 변수 이름 변경 */
        data keep.closest_year_&year;
            set keep.closest_year_&year(rename=(MOV20_WEK_FREQ_ID=EXERCI_FREQ_RSPS_CD));
        run;

    %end;

%mend rename_variable_2009_2013;
%rename_variable_2009_2013;


/* closest_year 변수 값에 따라 그룹별로 데이터 추출 및 NHID_GJ_&i 데이터와 연결 */
proc sql noprint;
    select distinct closest_year into :year_list separated by ' '
    from keep.dm_year_check_closest_year
    where closest_year is not null; /* NULL 값 제외 */
quit;

%macro split_and_join_by_closest_year;

    /* 각 closest_year 값에 대해 데이터 추출 및 연도별 데이터 연결 */
    %do i = 1 %to %sysfunc(countw(&year_list));
        %let year = %scan(&year_list, &i);

        proc sql;
            create table keep.closest_year_&year as
            select a.*, b.*
            from keep.dm_year_check_closest_year as a
            left join raw.NHID_GJ_&year as b
            on a.PERSON_ID = b.PERSON_ID
            where a.closest_year = &year; /* 현재 closest_year 그룹만 추출 */
        quit;

    %end;

%mend split_and_join_by_closest_year;
%split_and_join_by_closest_year;



%macro update_TM1_DRKQTY_RSPS_CD;

    /* 2004년부터 2008년까지 반복 처리 */
    %do year = 2004 %to 2008;

        /* 데이터셋 업데이트 */
        data keep.closest_year_&year;
            set keep.closest_year_&year;
            TM1_DRKQTY_RSPS_CD_n = TM1_DRKQTY_RSPS_CD * 1;
        run;

		data keep.closest_year_&year;
            set keep.closest_year_&year;
            drop TM1_DRKQTY_RSPS_CD;
        run;

		data keep.closest_year_&year;
            set keep.closest_year_&year;
            rename TM1_DRKQTY_RSPS_CD_n=TM1_DRKQTY_RSPS_CD;
        run;

    %end;

%mend update_TM1_DRKQTY_RSPS_CD;
%update_TM1_DRKQTY_RSPS_CD;


/* 병합 */
data keep.dm_closest_year;
    set keep.closest_year_2004-keep.closest_year_2013;
run;



PROC SQL;
   CREATE TABLE WORK.QUERY_FOR_MERGED_DATASET_WASH AS 
   SELECT t1.PERSON_ID, 
          t1.index_date, 
          t1.SICK_SYM, 
          t1.AGE_GROUP, t1.closest_year,
          t1.HEIGHT, 
          t1.WEIGHT, 
          t1.BP_HIGH, 
          t1.BP_LWST, 
          t1.BLDS, 
          t1.TOT_CHOLE, 
          t1.OLIG_PROTE_CD, 
          t1.SMK_STAT_TYPE_RSPS_CD, 
          t1.DRNK_HABIT_RSPS_CD, 
          t1.EXERCI_FREQ_RSPS_CD
      FROM KEEP.dm_closest_year t1;
QUIT;
/*모든변수에 결측이 없게 처리하기(7,114)*/
data keep.merged_dataset_wash;
    set QUERY_FOR_MERGED_DATASET_WASH;
    if cmiss(of _all_) = 0; 
run;


/*					
									(step 6)
제1형 당뇨병 관련 상병명 코드(E10.x)가 한 번이라도 부여된 자
*/
data keep.E10;
set keep.dm;
where substr(SICK_SYM,1,3) in ('E10');
run;
proc sort data=keep.E10 out=E10 nodupkey;/*25,244*/
by person_id;
run;
proc sql;
create table keep.final_dm as
    select distinct t1.*
    from keep.merged_dataset_wash t1 left join E10 t2 on (t1.person_id=t2.person_id)
where t1.person_id^=t2.person_id;
quit;

/*---------------------------------------------------------------------------------------------------*/
/*---------------------------------------------------------------------------------------------------*/
/*add */
/*---------------------------------------------------------------------------------------------------*/
/*---------------------------------------------------------------------------------------------------*/
/*1.age*/
data keep.final_dm;
set keep.final_dm;
if AGE_GROUP in ('7','8') then age_group_new='1.30';
else if AGE_GROUP in ('9','10') then age_group_new='2.40';
else if AGE_GROUP in ('11','12') then age_group_new='3.50';
else if AGE_GROUP in ('13','14') then age_group_new='4.60';
else if AGE_GROUP in ('15','16') then age_group_new='5.70';
else age_group_new='6.80<=';
run;

/*
2."gender" and "residential area" and "incom quantiles"

11 : 서울특별시
26 : 부산광역시
28 : 인천광역시
41 : 경기도
*/
proc sql;
create table keep.final_dm2 as
select distinct t1.*,t2.sex,
									(case when t2.sido in ('11','26','28','41') then '1.urban'
													else '2.rural' end)as residential_area,t2.CTRB_PT_TYPE_CD,
									(case when '0'<=t2.CTRB_PT_TYPE_CD<='3' then '1.0-3'
											 when '4'<=t2.CTRB_PT_TYPE_CD<='6' then '2.4-6'
											 when '7'<=t2.CTRB_PT_TYPE_CD then '3.7-10'
									end)as incom_quantiles
from keep.final_dm t1 left join use.jk t2 on (t1.person_id=t2.person_id and substr(t1.index_date,1,4)=t2.STND_Y);
quit;

/*
3. Duration of DM diagnosis (year)
	  : DM을 진단받은 기간측정
*/
proc sort data=keep.dm2 out=dm2_du ;/*187,890*/
by person_id RECU_FR_DT;
run;

proc sql;
create table keep.DM_year as
select distinct t1.person_id,t1.index_date,max(t2.RECU_FR_DT)as max
from keep.final_dm2 t1 left join dm2_du t2 
								on (t1.PERSON_ID=t2.PERSON_ID and t1.index_date<=t2.RECU_FR_DT)
group by t1.person_id;
quit;
data keep.DM_year_day;
set keep.DM_year;
Duration_of_DM_diagnosis_year=intck('day',input(index_date,yymmdd8.),input(max,yymmdd8.))/365;
run;
proc sql;
create table keep.final_dm3 as
select distinct t1.*,t2.Duration_of_DM_diagnosis_year
from keep.final_dm2 t1 left join keep.DM_year_day t2 on (t1.PERSON_ID=t2.PERSON_ID);
quit;
proc univariate data=keep.final_dm3;/*check*/
var Duration_of_DM_diagnosis_year;
run;


/*
4.Medication possession rate(%) 

[MPR:복약순응도]
=>총 약물을 조제 받은 일수(마지막 방문시 조제일수 제외)를
     약물을 처음 처방 받은 첫날부터 마지막으로 약물을 처방받은 날까지의
     기간으로 나눈 값으로 계산
=>MPR이 80%이상일 경우 복약순응군으로 간주
=>keep.final_dm3
----------------------------------------------------------------
[당뇨약제 데이터셋]
=>keep.dm_drug_60_id(약 조제관련된거는 60테이블만 사용하면됨)

1일투약량(DD_EXEC_FREQ)
총투여일수또는실시횟수(MDCN_EXEC_FREQ)
*/
proc sql;

create table dm_drug_60_id as
select distinct t2.PERSON_ID,t2.KEY_SEQ,t2.RECU_FR_DT,
				   min(t2.RECU_FR_DT)as min_date,max(t2.RECU_FR_DT)as max_date,t2.MDCN_EXEC_FREQ,
				   (case when t2.RECU_FR_DT^=max(t2.RECU_FR_DT)
				   					or t2.RECU_FR_DT=min(t2.RECU_FR_DT)
									then t2.MDCN_EXEC_FREQ end)as drug_day_sum_use
from keep.final_dm3 t1 left join keep.dm_drug_60_id t2 on (t1.PERSON_ID=t2.PERSON_ID)
group by t2.person_id
order by t2.PERSON_ID,t2.RECU_FR_DT;


create table dm_drug_60_id2 as
select distinct PERSON_ID,min_date,max_date,
					(sum(drug_day_sum_use))as drug_day_sum
from dm_drug_60_id
group by person_id;

quit;
data dm_drug_60_id3;
set dm_drug_60_id2;
day_count=intck('day',input(min_date,yymmdd8.),input(max_date,yymmdd8.));
run;
proc sql;
create table keep.final_dm_fin as
select distinct t1.*,t2.day_count,t2.drug_day_sum
from keep.final_dm3 t1 left join dm_drug_60_id3 t2 on (t1.PERSON_ID=t2.PERSON_ID);
quit;



/*final wash-out*/
data keep.final_dm_fin1;
set keep.final_dm_fin;
where Duration_of_DM_diagnosis_year>=4;
run;
data keep.final_dm_fin2;
set keep.final_dm_fin1;
where day_count is not null;
run;
proc sql;
create table keep.final_dm_final as
select distinct *,
					(case when Duration_of_DM_diagnosis_year<4 then '1.<4'
							 when 4<=Duration_of_DM_diagnosis_year<7 then '2.4~7'
							 when 7<=Duration_of_DM_diagnosis_year<10 then '3.7~10'
							 else '4.>=10' end
						) as Duration_of_DM_diagnosis,

						(case when ((day_count/drug_day_sum)*100)<80 then '1.<80'
									else '2.>=80' end)as Medication_possession_rate
from keep.final_dm_fin2;
quit;










/*---------------------------------------------------------------------------------------------------*/
															     /*table 확인 전 검진내용 수정*/
/*---------------------------------------------------------------------------------------------------*/
/*3,215*/
data keep.final_dm2_gj;
set keep.final_dm_final;

length bmi $15.;
length Fasting_blood_sugar $10.;
length Alcohol_consumption $20.;
length Physical_activity $10.;

/*1. BMI = 체중(kg) / 신장(m)²*/
if (WEIGHT/((HEIGHT*0.01)**2))<18.5 then bmi='1.＜18.5';
else if 18.5<=(WEIGHT/((HEIGHT*0.01)**2))<23 then bmi='2.18.5~22.9';
else if 23<=(WEIGHT/((HEIGHT*0.01)**2))<25 then bmi='3. 23.0~24.9';
else if (WEIGHT/((HEIGHT*0.01)**2))>=25 then bmi='4.>=25';

/*2. Systolic blood pressure*/
if BP_HIGH<130 then Systolic_blood_pressure='1.<130';
else if BP_HIGH>=130 then Systolic_blood_pressure='2.>=130';

/*3. Diastolic blood pressure*/
if BP_LWST<85 then Diastolic_blood_pressure='1.<85';
else if BP_LWST>=85 then Diastolic_blood_pressure='2.>=85';

/*4.Fasting blood sugar*/
if BLDS<100 then Fasting_blood_sugar='1.<100';
else if BLDS>=100 then Fasting_blood_sugar='2.>=100';

/*5. Total cholesterol*/
if TOT_CHOLE<220 then Total_cholesterol='1.<220';
else if TOT_CHOLE>=220 then Total_cholesterol='2.>=220';

/*6. Proteinuria*/
if OLIG_PROTE_CD in ('1') then Proteinuria='1.Negative';
else if '2'<=OLIG_PROTE_CD then Proteinuria='2.Positive';

/*7. Smoking*/
if SMK_STAT_TYPE_RSPS_CD in ('1') then Smoking='1.Never';
else if SMK_STAT_TYPE_RSPS_CD in ('2') then Smoking='2.Quit';
else if SMK_STAT_TYPE_RSPS_CD in ('3') then Smoking='3.Current';

/*8. Alcohol consumption*/
if DRNK_HABIT_RSPS_CD in ('1') then Alcohol_consumption='1.1 time/month';
else if DRNK_HABIT_RSPS_CD in ('2','3') then Alcohol_consumption='2.1~4 times/month';
else if DRNK_HABIT_RSPS_CD in ('4','5') then Alcohol_consumption='3.≥Twice/week';

/*9.Physical activity*/
if EXERCI_FREQ_RSPS_CD in ('1') then Physical_activity='1.None';
else if EXERCI_FREQ_RSPS_CD in ('2') then Physical_activity='2.1~2';
else if EXERCI_FREQ_RSPS_CD in ('3') then Physical_activity='3.3~4';
else if EXERCI_FREQ_RSPS_CD in ('4') then Physical_activity='2.5~6';
else if EXERCI_FREQ_RSPS_CD in ('5') then Physical_activity='3.Everyday';

where DRNK_HABIT_RSPS_CD not in ('8') and EXERCI_FREQ_RSPS_CD not in ('8');

keep PERSON_ID index_date age_group_new SEX residential_area incom_quantiles 
		bmi Fasting_blood_sugar Total_cholesterol Proteinuria Smoking Alcohol_consumption 
		Physical_activity Systolic_blood_pressure Diastolic_blood_pressure
		Duration_of_DM_diagnosis Medication_possession_rate;

run;





/*---------------------------------------------------------------------------------------------------*/
															     /*table 확인용 freq*/
/*---------------------------------------------------------------------------------------------------*/
/*keep.complications*/
/*합병증 전체 추출*/
data keep.complications_name;
set keep.complications;

length compli_name  $50.;

if
		/*심혈관질환 Cardiovascular Disease (CVD)*/
		'I200'<=substr(SICK_SYM,1,4)<='I251'
		 or 'I253'<=substr(SICK_SYM,1,4)<='I259'
		 or 'I500'<=substr(SICK_SYM,1,4)<='I509'
		 or 'I700'<=substr(SICK_SYM,1,4)<='I719'
then compli_name='Cardiovascular_Disease';

else if
		 /*뇌혈관질환 Cerebrovascular Disease*/
		  'G450'<=substr(SICK_SYM,1,4)<='G459'
		 or 'I630'<=substr(SICK_SYM,1,4)<='I639'
		 or 'I650'<=substr(SICK_SYM,1,4)<='I669'
then compli_name='Cerebrovascular_Disease';

else if
		 /*말초혈관질환 Peripheral Vascular Disease (PVD)*/
		  substr(SICK_SYM,1,4) in ('E115','E135','E145','I738','I739','I771')
		 or 'I790'<=substr(SICK_SYM,1,4)<='I798'
		 or 'K551'<=substr(SICK_SYM,1,4)<='K559'
		 or 'Z958'<=substr(SICK_SYM,1,4)<='Z959'
then compli_name='Peripheral_Vascular_Disease';

else if
		 /*눈질환 Ocular Disease / Eye Disease*/
		  substr(SICK_SYM,1,4) in ('E113','E133','E143','H540','H549')
		 or 'H330'<=substr(SICK_SYM,1,4)<='H368'
		 or 'H540'<=substr(SICK_SYM,1,4)<='H549'
then compli_name='Eye_Disease';


else if
		 /*신장질환 Kidney Disease (Renal Disease)*/
		  substr(SICK_SYM,1,4) IN ('E112','E132','E142','N289')
		 or 'N030'<=substr(SICK_SYM,1,4)<='N039'
		 or 'N050'<=substr(SICK_SYM,1,4)<='N059'
		 or 'N170'<=substr(SICK_SYM,1,4)<='N179'
		 or 'N250'<=substr(SICK_SYM,1,4)<='N259'
		 or 'Z490'<=substr(SICK_SYM,1,4)<='Z492'
		 or substr(SICK_SYM,1,4) IN ('Z992')
then compli_name='Kidney_Disease';


else if
		 /*신경병증 Neuropathy*/
		  substr(SICK_SYM,1,4) IN ('E114','E124','E134','E144','G538','G629','G632','G640')
		 or 'G560'<=substr(SICK_SYM,1,4)<='G598'
		 or 'G900'<=substr(SICK_SYM,1,4)<='G909'
		 or 'G990'<=substr(SICK_SYM,1,4)<='G998'
then compli_name='Neuropathy';

else if
		 /*족부질환 Foot Disease (Diabetic Foot Disease in case of diabetes context)*/
		  substr(SICK_SYM,1,3) IN ('L97','R02','S80','S81','S90','S91','T13','Z89')
then compli_name='Foot_Disease';
run;

proc sort data=keep.complications_name out=complications;/*571,612*/
by person_id RECU_FR_DT;
run;
proc sort data=complications out=complications_du nodupkey;/*571,612*/
by person_id compli_name;
run;
proc sql;
create table final_dm_complications as
select distinct t1.person_id,t1.index_date
					,(case when (t1.person_id=t2.person_id) and (t1.index_date<t2.RECU_FR_DT) then compli_name end)as complications
						,(case when (t1.person_id=t2.person_id) and (t1.index_date<t2.RECU_FR_DT) then RECU_FR_DT end)as complications_min_date
from keep.final_dm2_gj t1 left join complications_du2 t2 on (t1.person_id=t2.person_id)
having  complications is not null;
quit;
proc transpose data=final_dm_complications out=a;
by person_id;
var complications_min_date;
id complications;
run;
proc sql;
create table keep.final_dm_complications as
select distinct t1.*,
					(case when (t1.person_id=t2.person_id) and t2.Cardiovascular_Disease is not null then 1 else 0 end)as Cardiovascular_Disease,
					(case when (t1.person_id=t2.person_id) and t2.Cardiovascular_Disease is not null then t2.Cardiovascular_Disease end)as Cardiovascular_Disease_date,

					(case when (t1.person_id=t2.person_id) and t2.Neuropathy is not null then 1 else 0 end)as Neuropathy,
					(case when (t1.person_id=t2.person_id) and t2.Neuropathy is not null then t2.Neuropathy end)as Neuropathy_date,

					(case when (t1.person_id=t2.person_id) and t2.Peripheral_Vascular_Disease is not null then 1 else 0 end)as Peripheral_Vascular_Disease,
					(case when (t1.person_id=t2.person_id) and t2.Peripheral_Vascular_Disease is not null then t2.Peripheral_Vascular_Disease end)as Peripheral_Vascular_Disease_date,

					(case when (t1.person_id=t2.person_id) and t2.Cerebrovascular_Disease is not null then 1 else 0 end)as Cerebrovascular_Disease,
					(case when (t1.person_id=t2.person_id) and t2.Cerebrovascular_Disease is not null then t2.Cerebrovascular_Disease end)as Cerebrovascular_Disease_date,

					(case when (t1.person_id=t2.person_id) and t2.Eye_Disease is not null then 1 else 0 end)as Eye_Disease,
					(case when (t1.person_id=t2.person_id) and t2.Eye_Disease is not null then t2.Eye_Disease end)as Eye_Disease_date,

					(case when (t1.person_id=t2.person_id) and t2.Kidney_Disease is not null then 1 else 0 end)as Kidney_Disease,
					(case when (t1.person_id=t2.person_id) and t2.Kidney_Disease is not null then t2.Kidney_Disease end)as Kidney_Disease_date,

					(case when (t1.person_id=t2.person_id) and t2.Foot_Disease is not null then 1 else 0 end)as Foot_Disease,
					(case when (t1.person_id=t2.person_id) and t2.Foot_Disease is not null then t2.Foot_Disease end)as Foot_Disease_date
from keep.final_dm2_gj t1 left join a t2 on (t1.person_id=t2.person_id);
quit;


/*total*/
%macro count(a);

ods output OneWayFreqs=freq;
proc freq data=keep.final_dm_complications;
table &a;
run;

data freq_use(keep=&a use);
set freq;
use=cat(put(Frequency,comma8.),
							"(",
						round(Percent,0.01),
							")");
run;

%mend;
%count(SEX); 
%count(age_group_new); 
%count(residential_area); 
%count(incom_quantiles); 
%count(Duration_of_DM_diagnosis);
%count(bmi); 
%count(Systolic_blood_pressure); 
%count(Diastolic_blood_pressure);
%count(Fasting_blood_sugar);
%count(Total_cholesterol);
%count(Proteinuria);/*negative check*/
%count(Smoking);
%count(Alcohol_consumption); 
%count(Physical_activity); 
%count(Medication_possession_rate);

/*comlication*/
%macro freq(a);

ods output CrossTabFreqs=freq;
proc freq data=keep.final_dm_complications;
table &a * complications/nocol nopercent;
run;

data freq_use(keep=&a complications use);
set freq;
use=cat(put(Frequency,comma8.),
							"(",
						round(RowPercent,0.01),
							")");
where &a is not null and complications^=.;
run;

proc transpose data=freq_use out=transposed_summary prefix=complications_;
    by &a;
    id complications;
    var use;
run;

%mend;
%freq(SEX); 
%freq(age_group_new); 
%freq(residential_area); 
%freq(incom_quantiles); 
%freq(Duration_of_DM_diagnosis);
%freq(bmi); 
%freq(Systolic_blood_pressure); 
%freq(Diastolic_blood_pressure);
%freq(Fasting_blood_sugar);
%freq(Total_cholesterol);
%freq(Proteinuria);
%freq(Smoking);
%freq(Alcohol_consumption); 
%freq(Physical_activity); 
%freq(Medication_possession_rate);

/*p-value*/
%macro pvalue(a);
proc freq data=keep.final_dm_complications;
table &a * complications/chisq;
run;
%mend;
%pvalue(SEX); 
%pvalue(age_group_new); 
%pvalue(residential_area); 
%pvalue(incom_quantiles); 
%pvalue(Duration_of_DM_diagnosis);
%pvalue(bmi); 
%pvalue(Systolic_blood_pressure); 
%pvalue(Diastolic_blood_pressure);
%pvalue(Fasting_blood_sugar);
%pvalue(Total_cholesterol);
%pvalue(Proteinuria);
%pvalue(Smoking);
%pvalue(Alcohol_consumption); 
%pvalue(Physical_activity); 
%pvalue(Medication_possession_rate);






/*---------------------------------------------------------------------------------------------------*/
/*---------------------------------------------------------------------------------------------------*/
																/*추후 진료내역 연결*/
/*---------------------------------------------------------------------------------------------------*/
/*---------------------------------------------------------------------------------------------------*/
proc sql;/*질병들에 대한 정렬전에 취합*/
create table keep.final_dm_sick as
    select distinct t1.person_id,t2.KEY_SEQ,t2.SEQ_NO,t2.RECU_FR_DT,t2.SICK_SYM
    from keep.final_dm_complications t1 left join use.T40_ID t2 
								 on (t1.person_id=t2.person_id and t1.index_date<=t2.RECU_FR_DT)
order by t1.PERSON_ID,t2.RECU_FR_DT,t2.KEY_SEQ,t2.SEQ_NO;
quit;
proc transpose data=keep.final_dm_sick out=final_dm_sick_trans;
var SICK_SYM;
by person_id RECU_FR_DT KEY_SEQ;
run;
data final_dm_sick_trans2;/*902,995*/
    set final_dm_sick_trans;
    length combined_col $500; 

    /* 변수 합치기 */
    sick_all = catx('-', of COL1-COL30); 
keep PERSON_ID KEY_SEQ RECU_FR_DT sick_all;
run;






/*약물 & 수술 및 시술*/
libname data "D:\★낭파일\★학교연구";/*용량문제로 라이브러리 변경*/

proc sql;/*3:02:42.14*/
create table data.drugset_T30_0208 as
    select distinct  t1.person_id,
						t2.CLAUSE_CD,t2.ITEM_CD,t2.DIV_TYPE_CD,t2.KEY_SEQ,t2.SEQ_NO,t2.DIV_CD
    from final_dm_sick_trans2 t1 left join use.T30_0208 t2 
								 					on (t1.KEY_SEQ=t2.KEY_SEQ);

create table data.drugset_T30_0913 as
    select distinct t1.person_id,
						t2.CLAUSE_CD,t2.ITEM_CD,t2.DIV_TYPE_CD,t2.KEY_SEQ,t2.SEQ_NO,t2.DIV_CD
    from final_dm_sick_trans2 t1 left join use.T30_0913 t2 
								 					on (t1.KEY_SEQ=t2.KEY_SEQ);
quit;

%macro data(a,b);
data data.&b;
set data.&a;
where &where;
run;
%mend;

%let where=(CLAUSE_CD in ('01') and '01'<=ITEM_CD<='03');/*drug*/
%data(drugset_T30_0208,drug_0208);
%data(drugset_T30_0913,drug_0913);
data data.all_drug_t30_data;/*808,144*/
set data.drug_0208 data.drug_0913;
run;

%let where=(CLAUSE_CD in ('04') and ITEM_CD in ('01','02','03','05')) or
				 (CLAUSE_CD in ('05') and ITEM_CD in ('01')) or
				 (CLAUSE_CD in ('06')) or
				 (CLAUSE_CD in ('08') and ITEM_CD in ('01'));/*Treatment*/
%data(drugset_T30_0208,Treatment_0208);
%data(drugset_T30_0913,Treatment_0913);
data data.all_Treatment_t30_data;/*889,708*/
set data.Treatment_0208 data.Treatment_0913;
run;


proc sort data=data.all_drug_t30_data;
by person_id KEY_SEQ;
run;
proc transpose data=data.all_drug_t30_data out=all_drug_t30_data;
var DIV_CD;
by person_id KEY_SEQ;
run;
data keep.all_drug_t30_data2(keep=KEY_SEQ all);/*44,500*/
    set all_drug_t30_data;
    length combined_col $500; 

    /* 변수 합치기 */
    all = catx('-', of COL1-COL22); 
run;


proc sort data=data.all_Treatment_t30_data;
by person_id KEY_SEQ;
run;
proc transpose data=data.all_Treatment_t30_data out=all_Treatment_t30_data;
var DIV_CD;
by person_id KEY_SEQ;
run;
data keep.all_Treatment_t30_data3(keep=KEY_SEQ all);/*44,500*/
    set all_Treatment_t30_data;
    length combined_col $500; 

    /* 변수 합치기 */
    all = catx('-', of COL1-COL378); 
where ;
run;
data all_Treatment_t30_data3;
set keep.all_Treatment_t30_data3;
where all is not null;
run;


/*
fin

final_dm_sick_trans2   
*/
proc sql;
create table data.final_dataset_use as
select t1.*,
		(case when (t1.KEY_SEQ=t2.KEY_SEQ)then t2.all else 'none' end) as drug,
		(case when (t1.KEY_SEQ=t3.KEY_SEQ) then t3.all else 'none' end) as Treatment,
		(case when ((t1.person_id=t4.person_id) and (t1.RECU_FR_DT=t4.Cardiovascular_Disease_date) 
							and t4.Cardiovascular_Disease=1) then 1 else 0 end)as Cardiovascular_Disease, 
		(case when ((t1.person_id=t4.person_id) and (t1.RECU_FR_DT=t4.Neuropathy_date) 
							and t4.Neuropathy=1) then 1 else 0 end)as Neuropathy,
		(case when ((t1.person_id=t4.person_id) and (t1.RECU_FR_DT=t4.Peripheral_Vascular_Disease_date) 
							and t4.Peripheral_Vascular_Disease=1) then 1 else 0 end)as Peripheral_Vascular_Disease,
		(case when ((t1.person_id=t4.person_id) and (t1.RECU_FR_DT=t4.Cerebrovascular_Disease_date) 
							and t4.Cerebrovascular_Disease=1) then 1 else 0 end)as Cerebrovascular_Disease,
    	(case when ((t1.person_id=t4.person_id) and (t1.RECU_FR_DT=t4.Eye_Disease_date) 
							and t4.Eye_Disease=1) then 1 else 0 end)as Eye_Disease,
		(case when ((t1.person_id=t4.person_id) and (t1.RECU_FR_DT=t4.Kidney_Disease_date) 
							and t4.Kidney_Disease=1) then 1 else 0 end)as Kidney_Disease,
		(case when ((t1.person_id=t4.person_id) and (t1.RECU_FR_DT=t4.Foot_Disease_date) 
							and t4.Foot_Disease=1) then 1 else 0 end)as Foot_Disease
from final_dm_sick_trans2 t1 left join keep.all_drug_t30_data2 t2 on (t1.KEY_SEQ=t2.KEY_SEQ)
									  left join all_Treatment_t30_data3 t3 on (t1.KEY_SEQ=t3.KEY_SEQ)
									  left join keep.final_dm_complications t4 on (t1.person_id=t4.person_id)
;
quit;
proc sort data=data.final_dataset_use;
by person_id RECU_FR_DT;
run;
proc sort data=data.final_dataset_use out=person nodupkey;/*check=3215*/
by person_id;
run;


/*only 인구학적변수,생활습관변수,건강특징변수 dataset*/
PROC SQL;
   CREATE TABLE keep.QUERY_FOR_FINAL_DM_COMPLICATIONS AS 
   SELECT t1.PERSON_ID, 
          t1.age_group_new, 
          t1.SEX, 
          t1.residential_area, 
          t1.incom_quantiles, 
          t1.Duration_of_DM_diagnosis, 
          t1.Medication_possession_rate, 
          t1.bmi, 
          t1.Fasting_blood_sugar, 
          t1.Alcohol_consumption, 
          t1.Physical_activity, 
          t1.Systolic_blood_pressure, 
          t1.Diastolic_blood_pressure, 
          t1.Total_cholesterol, 
          t1.Proteinuria, 
          t1.Smoking
      FROM KEEP.FINAL_DM_COMPLICATIONS t1;
QUIT;