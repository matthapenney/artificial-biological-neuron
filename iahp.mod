TITLE slow Ca-dependent potassium current (AHP-current)

COMMENT
        *********************************************
        reference:      McCormick, Wang & Huguenard (1993) 
			Cerebral Cortex 3(5), 387-398
        found in:       bullfrog sympathetic ganglion cells
        *********************************************
	Assembled for MyFirstNEURON by Arthur Houweling
ENDCOMMENT

INDEPENDENT {t FROM 0 TO 1 WITH 1 (ms)}

NEURON {
	SUFFIX iAHP
	USEION k READ ek WRITE ik
	USEION ca READ cai
        RANGE gkbar, m_inf, tau_m, ik
}

UNITS {
	(mA) = (milliamp)
	(mV) = (millivolt)
	(mM) = (milli/liter)
}

PARAMETER {I
	v		(mV)
	celsius		(degC)
	dt		(ms)
	ek		(mV)
	cai		(mM)
	gkbar= 0.000207	(mho/cm2)
}

STATE {
	m
}

ASSIGNED {
	ik		(mA/cm2)
	tau_m		(ms)
	m_inf
	tadj
}

BREAKPOINT { 
	SOLVE states :METHOD euler
	ik = gkbar * m*m * (v-ek)
}

:DERIVATIVE states {
:       rates(v,cai)
:
:       m'= (m_inf-m) / tau_m 
:}
  
PROCEDURE states() {
        rates(v,cai)

        m= m + (1-exp(-dt/tau_m))*(m_inf-m)
}

UNITSOFF
INITIAL {
	tadj = 3^((celsius-23.5)/10)
	rates(v,cai)
	m = m_inf
}

PROCEDURE rates( v(mV), cai(mM)) {  LOCAL a,b
	a = 1200 * cai^2
	b = 0.001
	tau_m = 1/(a+b) / tadj
        m_inf = a/(a+b)
}
UNITSON






