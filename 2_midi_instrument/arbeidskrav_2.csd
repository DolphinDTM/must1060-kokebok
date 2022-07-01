<CsoundSynthesizer>

<CsOptions>
-odac -Ma -b16 -B1024
</CsOptions>

<CsInstruments>

/* This code is written for two MIDI controllers, one running through
   MIDI channel 1 and the other through MIDI channel 2. */

sr = 44100
ksmps = 10
0dbfs = 1
nchnls = 1

;Initialize all ADSR-values before instruments start.

initc7 1, 14, 0.001     ;Attack 1 (MIDI chn 1, CC #14, init value 0.001)
initc7 1, 15, 0.0001    ;Decay 1
initc7 1, 16, 1         ;Sustain 1
initc7 1, 17, 0.001     ;Release 1

initc7 1, 18, 0.001     ;Attack 2
initc7 1, 19, 0.0001    ;Decay 2
initc7 1, 20, 1         ;Sustain 2
initc7 1, 21, 0.001     ;Release 2

;Init all mix faders
initc7 2, 36, 1         ;Sawtooth
initc7 2, 37, 1         ;Sine
initc7 2, 38, 1         ;Square

instr 1
    kCps cpsmidib 2   ;Convert MIDI NN and pitchbend to CPS
    iVelo ampmidi 0.1 ;Get velocity from MIDI keyboard

    ;Get CC values from fadere
    kVol1 ctrl7 2, 36, 0, 1 ;MIDI chn 2, CC #36, min 0, max 1.
    kVol2 ctrl7 2, 37, 0, 1
    kVol3 ctrl7 2, 38, 0, 1

    ;Multiply velocity values with the fader value.
    ;This is one way to individually control the loudness of oscillators.
    kAmp1 = iVelo*kVol1
    kAmp2 = iVelo*kVol2
    kAmp3 = iVelo*kVol3

    ;Get ADSR values from MIDI CC
    iAtk1 ctrl7 1, 14, 0.001, 1
    iDec1 ctrl7 1, 15, 0.0001, 1
    iSus1 ctrl7 1, 16, 0, 1
    iRel1 ctrl7 1, 17, 0.001, 1

    iAtk2 ctrl7 1, 18, 0.001, 1
    iDec2 ctrl7 1, 19, 0.0001, 1
    iSus2 ctrl7 1, 20, 0, 1
    iRel2 ctrl7 1, 21, 0.001, 1

    ;Define ADSR envelope with the MIDI CC variables
    aEnv1 madsr iAtk1, iDec1, iSus1, iRel1
    aEnv2 madsr iAtk2, iDec2, iSus2, iRel2

    ;Sawtooth oscillator
    aOsc1 vco2 kAmp1, kCps

    ;Sine oscillator, 1 octave higher
    aOsc2 oscil kAmp2, kCps*2

    ;Square oscillator, slight detune
    aOsc3 vco2 kAmp3, kCps*1.005, 10

    ;Output all oscillators
    out aOsc1*aEnv1
    out aOsc2*aEnv2
    out aOsc3*aEnv1
endin

</CsInstruments>

<CsScore>
</CsScore>

</CsoundSynthesizer>
