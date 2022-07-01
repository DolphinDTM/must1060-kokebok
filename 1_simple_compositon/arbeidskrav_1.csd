<CsoundSynthesizer>
<CsOptions>
;DAC output
-odac
</CsOptions>
<CsInstruments>
;Sample rate at 44.1kHz, 0dB full scale represented as 1.
sr = 44100
0dbfs = 1

;Defines the instrument named "Bass"
instr Bass

  ;Gets values for amplitude and pulsewidth from p-fields in score.
	kAmp = p4*0.8
	kPW = p6

	;Henter MIDI-notenummeret fra parameter og konverterer det til frekvens (cps)
  ;Grabs the MIDI note number value from a p-field and converts it to hertz.
	kCps = cpsmidinn(p5)

	;Definerer omhyllingskurve til instrumentet
	;Defines ADSR envelope for the instrument.
	aEnv madsr 0.0001, 0.25, 0, 0.001

	;Square wave oscillator with PWM.
	aPulse vco2 kAmp, kCps, 4, kPW, 0, 0.25

	;Multiply the oscillator sound with the ADSR envelope and send to output.
	out aPulse*aEnv

;Close the instrument block.
endin

instr Chord

	kAmp = p4*0.5
	kCps = cpsmidinn(p5)

	aEnv madsr 0.0001, 0.075, 0.2, 0.0001
	aSaw vco2 kAmp, kCps, 0
	out aSaw*aEnv

endin

;Kick-drum
instr Kick

	kAmp = p4*0.4
	aCps = 250

	;Amplitude envelope
	aEnv madsr 0.0001, 0.6, 0, 0.0001

	;Exponential curve for pitch
	aEnv expon 1, 0.25, 0.05

	aKick oscil kAmp, aCps*aEnv
	out aKick*aEnv

endin

;Noise percussion, snare-like
instr Perc

	kAmp = p4

  ;Control the ADSR decay with p-field 5.
	aEnv madsr 0.0001, p5, 0, 0.0001
	aNoise rand kAmp, 0.5
	out aNoise*aEnv

endin

</CsInstruments>

<CsScore>

/* This is by far not the most efficient way of writing Csound score,
   but I was new at the time so please forgive me. */

;Four repetitions
r 4

;Tempo
t 0 143

;p1			p2		p3		p4		p5		p6
;instr		start	length	amp		note	ramp

;Cm
i "Bass" 	0 		0.5		0.3 	36		0.95
i .			+		.	 	.		43		.
i . 		+		0.25	.		36		.
i .			+		0.5		.		43		.
i .			+		0.25	.		34		.

;Section end
s

r 3

t 0 143

i "Bass" 	0 		0.5		0.25 	36		0.95
i .			+		.	 	.		43		.
i . 		+		0.25	.		36		.
i .			+		0.5		.		43		.
i .			+		0.25	.		34		.

i "Chord"	0		0.25	0.5		63
i .			0		0.25	.		60
i .			0.5		.		.		63
i .			0.5		.		.		60
i .			1.25	0.5		.		62
i .			1.25	0.5		.		60

s

t 0 143

i "Bass" 	0 		0.5		0.25 	36		0.95
i .			+		.	 	.		43		.
i . 		+		0.25	.		36		.
i .			+		0.5		.		43		.
i .			+		0.25	.		34		.

i "Chord"	0		0.25	0.5		63
i .			0		0.25	.		60
i .			0.5		.		.		63
i .			0.5		.		.		60
i .			1.25	0.5		.		65
i .			1.25	0.5		.		60

s

r 4

t 0 143

i "Bass" 	0 		0.5		0.25 	39		0.95
i .			+		.	 	.		46		.
i . 		+		0.25	.		39		.
i .			+		0.5		.		46		.
i .			+		0.25	.		39		.

i "Chord"	0		0.25	0.5		67
i .			0		0.25	.		60
i .			0.5		.		.		67
i .			0.5		.		.		60
i .			1.25	0.5		.		65
i .			1.25	0.5		.		60

s

r 3

t 0 143

i "Bass" 	0 		0.5		0.25 	34		0.95
i .			+		.	 	.		41		.
i . 		+		0.25	.		34		.
i .			+		0.5		.		41		.
i .			+		0.25	.		34		.

i "Chord"	0		0.25	0.5		65
i .			0		0.25	.		60
i .			0.5		.		.		65
i .			0.5		.		.		60
i .			1.25	0.5		.		63
i .			1.25	0.5		.		60

s

t 0 143

i "Bass" 	0 		0.5		0.25 	34		0.95
i .			+		.	 	.		41		.
i . 		+		0.25	.		34		.
i .			+		0.5		.		41		.
i .			+		0.25	.		34		.

i "Chord"	0		0.5		0.5		65
i .			0		.		.		60
i .			0.5		.		.		63
i .			0.5		.		.		60
i .			1		.		.		62
i .			1		.		.		60
i .			1.5		.		.		58
i .			1.5		.		.		55

s

r 4

t 0 143

i "Bass" 	0 		0.5		0.25 	36		0.95
i .			+		.	 	.		43		.
i . 		+		0.25	.		36		.
i .			+		0.5		.		43		.
i .			+		0.25	.		36		.

i "Chord"	0		0.25	0.5		60
i .			0		0.25	.		55
i .			0.5		.		.		60
i .			0.5		.		.		55
i .			1.25	0.5		.		58
i .			1.25	0.5		.		55


r 3

t 0 143

i "Bass" 	0 		0.5		0.25 	36		0.95
i .			+		.	 	.		43		.
i . 		+		0.25	.		36		.
i .			+		0.5		.		43		.
i .			+		0.25	.		34		.

i "Chord"	0		0.25	0.5		63
i .			0		0.25	.		60
i .			0.5		.		.		63
i .			0.5		.		.		60
i .			1.25	0.5		.		62
i .			1.25	0.5		.		60

i "Kick"	0		1		0.75
i .			+		.		.

i "Perc"	0.5		0.5		0.20	0.1
i .			1.5		.		.		.

s

t 0 143

i "Bass" 	0 		0.5		0.25 	36		0.95
i .			+		.	 	.		43		.
i . 		+		0.25	.		36		.
i .			+		0.5		.		43		.
i .			+		0.25	.		34		.

i "Chord"	0		0.25	0.5		63
i .			0		0.25	.		60
i .			0.5		.		.		63
i .			0.5		.		.		60
i .			1.25	0.5		.		65
i .			1.25	0.5		.		60

i "Kick"	0		1		0.75
i .			+		.		.

i "Perc"	0.5		0.5		0.20	0.1
i .			1.0		0.25	0.05	.
i .			1.25	.		0.10	.
i .			1.5		.		0.20	.
i .			1.75	.		0.25	.

s

r 4

t 0 143

i "Bass" 	0 		0.5		0.25 	39		0.95
i .			+		.	 	.		46		.
i . 		+		0.25	.		39		.
i .			+		0.5		.		46		.
i .			+		0.25	.		39		.

i "Chord"	0		0.25	0.5		67
i .			0		0.25	.		60
i .			0.5		.		.		67
i .			0.5		.		.		60
i .			1.25	0.5		.		65
i .			1.25	0.5		.		60

i "Kick"	0		1		0.75
i .			+		.		.

i "Perc"	0.5		0.5		0.20	0.1
i .			1.5		0.5		.		.

s

r 3

t 0 143

i "Bass" 	0 		0.5		0.25 	34		0.95
i .			+		.	 	.		41		.
i . 		+		0.25	.		34		.
i .			+		0.5		.		41		.
i .			+		0.25	.		34		.

i "Chord"	0		0.25	0.5		65
i .			0		0.25	.		60
i .			0.5		.		.		65
i .			0.5		.		.		60
i .			1.25	0.5		.		63
i .			1.25	0.5		.		60

i "Kick"	0		1		0.75
i .			+		.		.

i "Perc"	0.5		0.5		0.20	0.1
i .			1.5		0.5		.		.

s

t 0 143

i "Bass" 	0 		0.5		0.25 	34		0.95
i .			+		.	 	.		41		.
i . 		+		0.25	.		34		.
i .			+		0.5		.		41		.
i .			+		0.25	.		34		.

i "Chord"	0		0.5		0.5		65
i .			0		.		.		60
i .			0.5		.		.		63
i .			0.5		.		.		60
i .			1		.		.		62
i .			1		.		.		60
i .			1.5		.		.		58
i .			1.5		.		.		55

i "Kick"	0		1		0.75
i .			+		.		.

i "Perc"	0.5		0.5		0.20	0.1
i .			1.0		0.5		0.20	0.2
i .			1.75	0.25	0.20	0.1

s

r 4

t 0 143

i "Bass" 	0 		0.5		0.25 	36		0.95
i .			+		.	 	.		43		.
i . 		+		0.25	.		36		.
i .			+		0.5		.		43		.
i .			+		0.25	.		36		.

i "Chord"	0		0.25	0.5		60
i .			0		0.25	.		55
i .			0.5		.		.		60
i .			0.5		.		.		55
i .			1.25	0.5		.		60
i .			1.25	0.5		.		55

i "Kick"	0		1		0.75
i .			+		.		.

i "Perc"	0.5		0.5		0.20	0.1
i .			1.5		0.5		.		.

s

</CsScore>
</CsoundSynthesizer>
