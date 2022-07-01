<CsoundSynthesizer>

<CsOptions>
-odac -iadc
-b32 -B2056
;-t60 ;(denne må skrus på hvis du skal spille uten MIDI-fil)
-Ma
-F 3_score.mid
</CsOptions>

<CsInstruments>

;Global Values
;------------------------------------------------------------
0dbfs = 1
sr = 44100
ksmps = 1
nchnls = 2
seed 0

;User Defined Opcodes (UDO)
;------------------------------------------------------------

;Enkel chorus-effekt
opcode chorus, aa, aakk
  aL, aR, kFreq, kDepth xin

  ;LFO som modulerer delaytiden.
  aLFO lfo kDepth, kFreq
  aLFO += kDepth ;polarisering

  ;variabel delay, legger til 25ms ekstra med delay pga fasing.
  aOutL vdelay aL, aLFO+25, 100
  aOutR vdelay aR, aLFO+25, 100

  xout aOutL, aOutR
endop

;Stereo Vocoder
opcode vocoders, aa, aaai
  aMod, aCarL, aCarR, iFFT xin

  ;FFT analyse av alle input-signal
  fModAnalyze pvsanal aMod, iFFT, iFFT/4, iFFT*2, 1
  fCarLAnalyze pvsanal aCarL, iFFT, iFFT/4, iFFT*2, 1
  fCarRAnalyze pvsanal aCarR, iFFT, iFFT/4, iFFT*2, 1

  ;Få amplituden fra modulator og kjører den gjennom frekvensene til carrier.
  fVocL pvsvoc fModAnalyze, fCarLAnalyze, 1, 1
  fVocR pvsvoc fModAnalyze, fCarRAnalyze, 1, 1

  ;Resynthesize
  aOutL pvsynth fVocL
  aOutR pvsynth fVocR

  xout aOutL, aOutR
endop

;Global Variables
;------------------------------------------------------------

;Gjør det mulig å bytte mellom sagtann- eller firkantbølge
giWaveform ftgen 0, 0, 0, -2, 0, 10
;Laste lydfil inn i tabell
giAmen ftgen 0, 0, 0, 1, "amenbreak.wav", 0, 0, 1
;Hammond-like waveform
giHammond ftgen 0, 0, 4096, 10, 1, 1/2, 1/3, 1/4, 1/6, 1/8, 1/10, 1/12, 1/16
;Default BPM to 60
gkBPM init 60
;Initialiserer variabel for glide.
gkOldCps init 0

giScale = 1/5

;MIDI Controllers
;------------------------------------------------------------
massign 1, "Detune"
massign 2, "Sampler"
massign 3, "Harmonizer"
massign 4, "Detune2"
massign 5, "ArpSynth"
massign 6, "Metronome"

;Globale definisjoner for CC gjør det enklere å bytte ut CC-nummer
;hvis man benytter seg en annen MIDI-kontroller.

giKeysChn     = 1   ;MIDI channel for keyboard
giPadsChn     = 2   ;MIDI channel for pad
giCtrlChn     = 3   ;MIDI channel for control surface

;Synth Params
giVibCC       = 1   ;Vibrato/Tremolo Depth
giDetCC       = 14  ;Detune
giWaveCC      = 74  ;Waveform

;Modwheel Toggle
giVibOnCC     = 73  ;Enable Vibrato
giTremOnCC    = 72  ;Enable Tremolo

;Synth ADSR
giAtkCC       = 61  ;Attack
giDecCC       = 62  ;Decay
giSusCC       = 63  ;Sustain
giRelCC       = 70  ;Release

;Synth Filter
giLPSynthCC   = 0   ;Cutoff Frequency
giLPAmpCC     = 36  ;Filter Envelope Amplitude
giLPAtkCC     = 52  ;Filter Envelope Attack
giLPDecCC     = 53  ;Filter Envelope Decay

;Multieffect
giChoFreqCC   = 15  ;Chorus Frequency
giChoDeptCC   = 16  ;Chorus Depth
giRevFdbkCC   = 17  ;Reverb Feedback Level
giRevCutCC    = 18  ;Reverb Cutoff Frequency

;Multieffect Mix
giChoMixCC    = 37  ;Chorus Mix
giRevMixCC    = 38  ;Reverb Mix
giShimMixCC   = 39  ;Shimmer Mix

;Breakbeat Effects
giBrkCutCC    = 3   ;Breakbeat Filter Cutoff
giBrkResCC    = 20  ;Breakbeat Filter Resonance
giBrkRevFbkCC = 9   ;Breakbeat Reverb Feedback Level
giBrkRevMixCC = 21  ;Breakbeat Reverb Mix Level

;Freeze Controls
giFreezeCC    = 28  ;Enable Freeze
giLPFreezeCC  = 15  ;Freeze Lowpass Filter

;Trigger Controls
giTrig16CC    = 29  ;Enable 16th Retrigger
giTrig24CC    = 30  ;Enable 16th Triplet Retrigger
giTrig32CC    = 31  ;Enable 32nd Retrigger

;Arpeggio Controls
giArpRateCC   = 20  ;Arpeggio Rate
giLPArpCC     = 21  ;Arpeggio Filter

;Initialization of controls
initc7 giKeysChn, giVibCC,       0
initc7 giKeysChn, giDetCC,       0
initc7 giCtrlChn, giWaveCC,      0

initc7 giCtrlChn, giVibOnCC,     0
initc7 giCtrlChn, giTremOnCC,    0

initc7 giPadsChn, giAtkCC,       0
initc7 giPadsChn, giDecCC,       0
initc7 giPadsChn, giSusCC,       1
initc7 giPadsChn, giRelCC,       0

initc7 giCtrlChn, giLPSynthCC,   1
initc7 giCtrlChn, giLPAmpCC,     0
initc7 giPadsChn, giLPAtkCC,     0.1
initc7 giPadsChn, giLPDecCC,     0.1

initc7 giKeysChn, giChoFreqCC,   0
initc7 giKeysChn, giChoDeptCC,   0
initc7 giKeysChn, giRevFdbkCC,   0.8
initc7 giKeysChn, giRevCutCC,    1

initc7 giCtrlChn, giChoMixCC,    1
initc7 giCtrlChn, giRevMixCC,    0.5
initc7 giCtrlChn, giShimMixCC,   1

initc7 giPadsChn, giBrkCutCC,    1
initc7 giPadsChn, giBrkResCC,    0.5
initc7 giPadsChn, giBrkRevFbkCC, 0.5
initc7 giPadsChn, giBrkRevMixCC, 0.25

initc7 giPadsChn, giFreezeCC,    0
initc7 giPadsChn, giLPFreezeCC,  1

initc7 giKeysChn, giArpRateCC,   0.5
initc7 giKeysChn, giLPArpCC,     1

;Signal Routing
;------------------------------------------------------------

connect "Detune",     "OutLeft",  "MultiFX",     "InLeft"
connect "Detune",     "OutRight", "MultiFX",     "InRight"

connect "Detune",     "OutLeft",  "Freeze",      "InLeft"
connect "Detune",     "OutRight", "Freeze",      "InRight"

connect "Detune2",    "OutLeft",  "Vocoder",     "CarrierLeft"
connect "Detune2",    "OutRight", "Vocoder",     "CarrierRight"

connect "ArpSynth",   "Output",   "Freeze",      "InLeft"
connect "ArpSynth",   "Output",   "Freeze",      "InRight"

connect "ArpSynth",   "Output",   "ArpReverb",   "InLeft"
connect "ArpSynth",   "Output",   "ArpReverb",   "InRight"

connect "ArpReverb",  "OutLeft",  "Freeze",      "InLeft"
connect "ArpReverb",  "OutRight", "Freeze",      "InRight"

connect "AmenBreak",  "OutLeft",  "Freeze",      "InLeft"
connect "AmenBreak",  "OutRight", "Freeze",      "InRight"

connect "AmenBreak",  "OutLeft",  "BreakVerb",   "InLeft"
connect "AmenBreak",  "OutRight", "BreakVerb",   "InRight"

connect "BreakVerb",  "OutLeft",  "Freeze",      "InLeft"
connect "BreakVerb",  "OutRight", "Freeze",      "InRight"

connect "Microphone", "Output",   "Vocoder",     "Modulator"

connect "Microphone", "Output",   "Harmonizer",  "Input"

connect "Vocoder",    "OutLeft",  "Freeze",      "InLeft"
connect "Vocoder",    "OutRight", "Freeze",      "InRight"

connect "Vocoder",    "OutLeft",  "MultiFX",     "InLeft"
connect "Vocoder",    "OutRight", "MultiFX",     "InRight"

connect "Harmonizer", "Output",   "Freeze",      "InLeft"
connect "Harmonizer", "Output",   "Freeze",      "InRight"

connect "MultiFX",    "OutLeft",  "Freeze",      "InLeft"
connect "MultiFX",    "OutRight", "Freeze",      "InRight"

connect "Freeze",     "OutLeft",  "Master",      "InLeft"
connect "Freeze",     "OutRight", "Master",      "InRight"

alwayson "Microphone"
alwayson "MultiFX"
alwayson "BreakVerb"
alwayson "ArpReverb"
alwayson "Vocoder"
alwayson "Freeze"
alwayson "Master"

;Instrument Definitions
;------------------------------------------------------------

instr Detune
  /**************************************

  DELOPPGAVE 1 - MIDI-styrt instrument

  **************************************/

  ;Hent amplitude og tonehøyde fra MIDI
  iAmp ampmidi 1
  kCps cpsmidib 2

  ;Legg til styring med MIDI CC
  kGetWave    ctrl7 giCtrlChn, giWaveCC, 0, 1.99
  kDetuneCtrl ctrl7 giKeysChn, giDetCC, 0, 2

  ;Hent iMode-verdi fra tabell
  kChangeMode table kGetWave, giWaveform

  ;Enkel LFO
  kVibAmount  ctrl7 giKeysChn, giVibCC, 0, 0.1
  kVib lfo kVibAmount, 6

  ;Toggle-knapper for vibrato og LFO
  kEnableVib  ctrl7 giCtrlChn, giVibOnCC, 0, 1
  kEnableTrem ctrl7 giCtrlChn, giTremOnCC, 0, 1

  ;Hvis vibrato er skrudd på, send til Cps.
  if kEnableVib = 1 then
    kCps *= kVib+1
  endif

  ;Hvis tremolo er skrudd på, send til Amp.
  if kEnableTrem = 1 then
    kTrem = 1-(kVib*10) ;få en verdi som faktisk gir mening som tremolo.
  else
    kTrem = 1
  endif

  ;Styring av detune-mengde. Distribuert både over under under tonesenteret.
  kDetuneUp1   = (kDetuneCtrl*0.04)+1
  kDetuneDown1 = (kDetuneCtrl*-0.04)+1
  kDetuneUp2   = (kDetuneCtrl*0.025)+1
  kDetuneDown2 = (kDetuneCtrl*-0.025)+1
  kDetuneUp3   = (kDetuneCtrl*0.01)+1
  kDetuneDown3 = (kDetuneCtrl*-0.01)+1

  ;Tilfeldige tall for hver oscillator sin fasekontroll
  iRand1 random 0, 1
  iRand2 random 0, 1
  iRand3 random 0, 1
  iRand4 random 0, 1
  iRand5 random 0, 1
  iRand6 random 0, 1

  ;Amplitude kontroll
  iAtk ctrl7 giPadsChn, giAtkCC, 0.001, 2
  iDec ctrl7 giPadsChn, giDecCC, 0.001, 2
  iSus ctrl7 giPadsChn, giSusCC, 0, 1
  iRel ctrl7 giPadsChn, giRelCC, 0.001, 2

  ;ADSR-kurve
  aEnv madsr iAtk, iDec, iSus, iRel

  ;Jevnt fordelt panorering.
  iPan1 = 0
  iPan2 = 1
  iPan3 = 0.8
  iPan4 = 0.2
  iPan5 = 0.4
  iPan6 = 0.6

  ;Skaler hver oscillator slik at ingen kan treffe 0dB.
  iScale = 1/6

  ;Tving oscillator til å renitialisere når man skifter iMode
  kUpdate changed kChangeMode
  if kUpdate = 1 then
    reinit REINIT_OSC
  endif

  REINIT_OSC:

  iMode = i(kChangeMode)

  ;Seks oscillatorer som kjører samtidig for å skape et fint teppe av lyd.
  aOsc1 vco2 iAmp*kTrem, kCps*kDetuneUp1, iMode, 0, iRand1
  aOsc1 *= iScale
  aOsc1L, aOsc1R pan2 aOsc1, iPan1

  aOsc2 vco2 iAmp*kTrem, kCps*kDetuneDown1, iMode, 0, iRand2
  aOsc2 *= iScale
  aOsc2L, aOsc2R pan2 aOsc2, iPan2

  aOsc3 vco2 iAmp*kTrem, kCps*kDetuneUp2, iMode, 0, iRand3
  aOsc3 *= iScale
  aOsc3L, aOsc3R pan2 aOsc3, iPan3

  aOsc4 vco2 iAmp*kTrem, kCps*kDetuneDown2, iMode, 0, iRand4
  aOsc4 *= iScale
  aOsc4L, aOsc4R pan2 aOsc4, iPan4

  aOsc5 vco2 iAmp*kTrem, kCps*kDetuneUp3, iMode, 0, iRand5
  aOsc5 *= iScale
  aOsc5L, aOsc5R pan2 aOsc5, iPan5

  aOsc6 vco2 iAmp*kTrem, kCps*kDetuneDown3, iMode, 0, iRand6
  aOsc6 *= iScale
  aOsc6L, aOsc6R pan2 aOsc6, iPan6

  ;Summer alle oscillatorene.
  aOscL = aOsc1L+aOsc2L+aOsc3L+aOsc4L+aOsc5L+aOsc6L
  aOscR = aOsc1R+aOsc2R+aOsc3R+aOsc4R+aOsc5R+aOsc6R

  ;Form volum etter ADSR-kurve.
  aOscL *= aEnv
  aOscR *= aEnv

  ;Filter kontroll
  iFilterAtk ctrl7 giPadsChn, giLPAtkCC, 0.001, 2
  iFilterDec ctrl7 giPadsChn, giLPDecCC, 0.001, 2
  iFilterAmp ctrl7 giCtrlChn, giLPAmpCC, 1, 100
  kCutCtrl   ctrl7 giCtrlChn, giLPSynthCC, 20, 20000

  ;Filterkurve
  kFilterEnv madsr iFilterAtk, iFilterDec, 0, iRel
  kCutFreq = kCutCtrl*((kFilterEnv*iFilterAmp)+1)

  ;Sjekk at cutoff ikke bestiger 20kHz for å unngå problemer.
  if kCutFreq > 20000 then
    kCutFreq = 20000
  else
    kCutFreq = kCutFreq
  endif

  ;Filter
  aOutL moogladder aOscL, kCutFreq, 0.3
  aOutR moogladder aOscR, kCutFreq, 0.3

  aOutL *= giScale
  aOutR *= giScale

  outleta "OutLeft",  aOutL
  outleta "OutRight", aOutR
endin

instr MultiFX
  /**************************************

  DELOPPGAVE 2 - Multieffekt-modul

  **************************************/

  aLeft  inleta "InLeft"
  aRight inleta "InRight"

  ;MIDI CC kontroller
  kChoFreq  ctrl7 giKeysChn, giChoFreqCC, 0.5, 10
  kChoDepth ctrl7 giKeysChn, giChoDeptCC, 0.1, 2
  kRevFeed ctrl7 giKeysChn, giRevFdbkCC, 0.1, 0.9
  kRevCut  ctrl7 giKeysChn, giRevCutCC, 20, 20000

  ;Mix-kontroll for alle effektene
  kChorVol ctrl7 giCtrlChn, giChoMixCC, 0, 1
  kRevVol  ctrl7 giCtrlChn, giRevMixCC, 0, 1
  kShimVol ctrl7 giCtrlChn, giShimMixCC, 0, 1

  ;Chorus effekt med egen UDO
  aChorusL, aChorusR chorus aLeft, aRight, kChoFreq, kChoDepth
  aChorusL *= kChorVol
  aChorusR *= kChorVol

  ;Reverb
  aReverbL, aReverbR reverbsc, aLeft+aChorusL, aRight+aChorusR, kRevFeed, kRevCut
  aReverbL *= kRevVol
  aReverbR *= kRevVol

  ;"Shimmer" ved å doble frekvensen til reverbsignalet med FFT analyse
  iFFT = 1024
  fAnalyzeL pvsanal aReverbL, iFFT, iFFT/4, iFFT*2, 0
  fAnalyzeR pvsanal aReverbR, iFFT, iFFT/4, iFFT*2, 0

  fShimmerL pvscale fAnalyzeL, 2
  fShimmerR pvscale fAnalyzeR, 2

  aShimmerL pvsynth fShimmerL
  aShimmerR pvsynth fShimmerR

  ;Litt tremolo på shimmer-effekten. To LFOer som kjører inni hverandre for å få mer variasjon.
  iTremAmp = 0.2
  kMod  lfo 0.4, 0.5
  kMod *= 0.5
  aTrem lfo iTremAmp, 10*kMod
  aTrem += 1-iTremAmp

  aShimmerL *= aTrem
  aShimmerR *= aTrem

  aShimmerL *= kShimVol
  aShimmerR *= kShimVol

  ;Summer alle effektene
  aOutL = aChorusL+aReverbL+aShimmerL
  aOutR = aChorusR+aReverbR+aShimmerR

  outleta "OutLeft",  aOutL
  outleta "OutRight", aOutR
endin

/**************************************

Ekstra instrumenter som skal brukes
til gjennomføring av musikalsk forløp.

**************************************/

;Sample-trigger med retrigger-funksjon
instr Sampler
  iNote notnum
  iAmp ampmidi 1

  ;Henter tempo fra score
  kBPM miditempo

  ;Hvor små skal hver sample cut være?
  iCutLength = 8 ;En 8-del
  kBeat = 60/kBPM
  kLength = kBeat*(4/iCutLength)

  ;Akkurat denne biten funker ikke som bare en 8.-del.
  if iNote = 49 then
    kLength *= 2
  else
    kLength = kLength
  endif

  kTrig16 ctrl7 giPadsChn, giTrig16CC, 0, 1
  kTrig24 ctrl7 giPadsChn, giTrig24CC, 0, 1
  kTrig32 ctrl7 giPadsChn, giTrig32CC, 0, 1

  if kTrig16+kTrig24+kTrig32 > 1 then
      ;Retrigger-limit på 0.2 sekund. Kun 3 instances om gangen.
      schedkwhen 1, 0.2, 3, "AmenBreak", 0, kLength, iNote, iAmp, iCutLength
    elseif kTrig16 = 1 then
      ;Retrigger-limit på en 16-del. Kun 1 instance.
      schedkwhen 1, kBeat/4, 1, "AmenBreak", 0, kBeat/4, iNote, iAmp, iCutLength
    elseif kTrig24 = 1 then
      ;Retrigger-limit på en 16-triol. Kun 1 instance.
      schedkwhen 1, kBeat/6, 1, "AmenBreak", 0, kBeat/6, iNote, iAmp, iCutLength
    elseif kTrig32 = 1 then
      ;Retrigger-limit på en 32-del. Kun 1 instance.
      schedkwhen 1, kBeat/8, 1, "AmenBreak", 0, kBeat/8, iNote, iAmp, iCutLength
    else
      ;Retrigger-limit på 0.2 sekund. Kun 3 instances om gangen.
      schedkwhen 1, 0.2, 3, "AmenBreak", 0, kLength, iNote, iAmp, iCutLength
  endif

endin

;Sampler Modul for Amen Break
instr AmenBreak
  iNote = p4
  iAmp = p5
  iCutLength = p6
  iLength = ftlen(giAmen)
  aEnv madsr 0.0001, 0.0001, 1, 0.01

  ;Hvor mange slag er det i fila?
  iBeats = 16

  ;Få target tempo fra score eller MIDI.
  kBPM miditempo

  ;Finner ut hvor mange cuts det blir totalt med de gitte instillingene.
  iCuts = iBeats/(4/iCutLength)

  ;Finn lengde på 1 beat i sec, deretter konverter til samples,
  ;for så å gange med antall beats i hele samplen.
  kNewLength = ((60/kBPM)*sr)*iBeats

  ;Frekvens justert etter tempo
  kCps = sr/kNewLength

  ;Sjekk notenummer og velg riktig slice henholdsvis.
  if iNote = 36 then
      iStart = 8/iCuts
    elseif iNote = 37 then
      iStart = 9/iCuts
    elseif iNote = 38 then
      iStart = 10/iCuts
    elseif iNote = 39 then
      iStart = 11/iCuts
    elseif iNote = 40 then
      iStart = 12/iCuts
    elseif iNote = 41 then
      iStart = 13/iCuts
    elseif iNote = 42 then
      iStart = 14/iCuts
    elseif iNote = 43 then
      iStart = 15/iCuts
    elseif iNote = 44 then
      iStart = 20/iCuts
    elseif iNote = 45 then
      iStart = 21/iCuts
    elseif iNote = 46 then
      iStart = 22/iCuts
    elseif iNote = 47 then
      iStart = 23/iCuts
    elseif iNote = 48 then
      iStart = 28/iCuts
    elseif iNote = 49 then
      iStart = 29/iCuts
    elseif iNote = 50 then
      iStart = 31/iCuts
    elseif iNote = 51 then
      iStart = 0
    else goto SKIP_SAMPLE
  endif

  ;Printer en advarsel og skipper playback hvis det skulle være nødvendig.
  if iStart >= 1 then
    prints "WARNING: Sample start value %d exceeds or is equal the total amount of cuts, which is %d\n", iCuts*iStart, iCuts
    goto SKIP_SAMPLE
  endif

  ;Iterer gjennom tabellen basert på Cps fra target tempo.
  aPlay phasor kCps, iStart
  aSample table aPlay*iLength, giAmen
  aSample *= iAmp
  aSample *= aEnv

  SKIP_SAMPLE:

  ;Filterkontroll
  kCutoff ctrl7 giPadsChn, giBrkCutCC, 0.001, 1
  kReso   ctrl7 giPadsChn, giBrkResCC, 0, 0.8

  ;Mekker en eksponensiell kurve for filter cutoff, for litt mer naturlig skalering.
  kCurved expcurve kCutoff, 8
  kCurved *= 20000

  aFilter moogladder aSample, kCurved, kReso

  aOut = aFilter
  aOut *= giScale

  outleta "OutLeft",  aOut
  outleta "OutRight", aOut
endin

;Enkel reverb til breakbeat-trommene.
instr BreakVerb
  aL inleta "InLeft"
  aR inleta "InRight"

  kRevFdbk ctrl7 giPadsChn, giBrkRevFbkCC, 0.1, 0.9
  kRevMix  ctrl7 giPadsChn, giBrkRevMixCC, 0, 0.5

  aRevL, aRevR reverbsc aL, aR, kRevFdbk, 8000

  aRevL *= kRevMix
  aRevR *= kRevMix

  outleta "OutLeft",  aRevL
  outleta "OutRight", aRevR
endin

;Harmonizer for vokal
instr Harmonizer
  aIn inleta "Input"

  kCps cpsmidib 2

  ;FFT-analyse for å repitche etterpå
  iFFT = 1024
  fAnalyze pvsanal aIn, iFFT, iFFT/4, iFFT*2, 0

  ;Analyser input pitch og finn faktor for å få target pitch.
  kPitch, kAmp pitchamdf aIn, 20, 2000
  if kPitch = 0 goto SKIP_HARMONIZER ;unngå divide by zero error.
  kCps /= kPitch ;Få repitching-faktor.
  ;printk 0.1, kCps

  ;Skaler til den nye tonen.
  fScale pvscale fAnalyze, kCps

  aOut pvsynth fScale

  SKIP_HARMONIZER:

  aOut *= giScale

  outleta "Output", aOut
endin

;Samme som forrige Detune, men denne routes gjennom vocoderen.
instr Detune2
  ;Hent amplitude og tonehøyde fra MIDI
  iAmp ampmidi 1
  kCps cpsmidib 2

  ;Legg til styring med MIDI CC
  kGetWave    ctrl7 giCtrlChn, giWaveCC, 0, 1.99
  kDetuneCtrl ctrl7 giKeysChn, giDetCC, 0, 2

  ;Hent iMode-verdi fra tabell
  kChangeMode table kGetWave, giWaveform

  ;Enkel LFO
  kVibAmount  ctrl7 giKeysChn, giVibCC, 0, 0.1
  kVib lfo kVibAmount, 6

  ;Toggle-knapper for vibrato og LFO
  kEnableVib  ctrl7 giCtrlChn, giVibOnCC, 0, 1
  kEnableTrem ctrl7 giCtrlChn, giTremOnCC, 0, 1

  ;Hvis vibrato er skrudd på, send til Cps.
  if kEnableVib = 1 then
    kCps *= kVib+1
  endif

  ;Hvis tremolo er skrudd på, send til Amp.
  if kEnableTrem = 1 then
    kTrem = 1-(kVib*10) ;få en verdi som faktisk gir mening som tremolo.
  else
    kTrem = 1
  endif

  ;Styring av detune-mengde. Distribuert både over under under tonesenteret.
  kDetuneUp1   = (kDetuneCtrl*0.04)+1
  kDetuneDown1 = (kDetuneCtrl*-0.04)+1
  kDetuneUp2   = (kDetuneCtrl*0.025)+1
  kDetuneDown2 = (kDetuneCtrl*-0.025)+1
  kDetuneUp3   = (kDetuneCtrl*0.01)+1
  kDetuneDown3 = (kDetuneCtrl*-0.01)+1

  ;Tilfeldige tall for hver oscillator sin fasekontroll
  iRand1 random 0, 1
  iRand2 random 0, 1
  iRand3 random 0, 1
  iRand4 random 0, 1
  iRand5 random 0, 1
  iRand6 random 0, 1

  ;Amplitude kontroll
  iAtk ctrl7 giPadsChn, giAtkCC, 0.001, 2
  iDec ctrl7 giPadsChn, giDecCC, 0.001, 2
  iSus ctrl7 giPadsChn, giSusCC, 0, 1
  iRel ctrl7 giPadsChn, giRelCC, 0.001, 2

  ;ADSR-kurve
  aEnv madsr iAtk, iDec, iSus, iRel

  ;Jevnt fordelt panorering.
  iPan1 = 0
  iPan2 = 1
  iPan3 = 0.8
  iPan4 = 0.2
  iPan5 = 0.4
  iPan6 = 0.6

  ;Skaler hver oscillator slik at ingen kan treffe 0dB.
  iScale = 1/6

  ;Tving oscillator til å renitialisere når man skifter iMode
  kUpdate changed kChangeMode
  if kUpdate = 1 then
    reinit REINIT_OSC
  endif

  REINIT_OSC:

  iMode = i(kChangeMode)

  ;Seks oscillatorer som kjører samtidig for å skape et fint teppe av lyd.
  aOsc1 vco2 iAmp*kTrem, kCps*kDetuneUp1, iMode, 0, iRand1
  aOsc1 *= iScale
  aOsc1L, aOsc1R pan2 aOsc1, iPan1

  aOsc2 vco2 iAmp*kTrem, kCps*kDetuneDown1, iMode, 0, iRand2
  aOsc2 *= iScale
  aOsc2L, aOsc2R pan2 aOsc2, iPan2

  aOsc3 vco2 iAmp*kTrem, kCps*kDetuneUp2, iMode, 0, iRand3
  aOsc3 *= iScale
  aOsc3L, aOsc3R pan2 aOsc3, iPan3

  aOsc4 vco2 iAmp*kTrem, kCps*kDetuneDown2, iMode, 0, iRand4
  aOsc4 *= iScale
  aOsc4L, aOsc4R pan2 aOsc4, iPan4

  aOsc5 vco2 iAmp*kTrem, kCps*kDetuneUp3, iMode, 0, iRand5
  aOsc5 *= iScale
  aOsc5L, aOsc5R pan2 aOsc5, iPan5

  aOsc6 vco2 iAmp*kTrem, kCps*kDetuneDown3, iMode, 0, iRand6
  aOsc6 *= iScale
  aOsc6L, aOsc6R pan2 aOsc6, iPan6

  ;Summer alle oscillatorene.
  aOscL = aOsc1L+aOsc2L+aOsc3L+aOsc4L+aOsc5L+aOsc6L
  aOscR = aOsc1R+aOsc2R+aOsc3R+aOsc4R+aOsc5R+aOsc6R

  ;Form volum etter ADSR-kurve.
  aOscL *= aEnv
  aOscR *= aEnv

  ;Filter kontroll
  iFilterAtk ctrl7 giPadsChn, giLPAtkCC, 0.001, 2
  iFilterDec ctrl7 giPadsChn, giLPDecCC, 0.001, 2
  iFilterAmp ctrl7 giCtrlChn, giLPAmpCC, 1, 100
  kCutCtrl   ctrl7 giCtrlChn, giLPSynthCC, 20, 20000

  ;Filterkurve
  kFilterEnv madsr iFilterAtk, iFilterDec, 0, iRel
  kCutFreq = kCutCtrl*((kFilterEnv*iFilterAmp)+1)

  ;Sjekk at cutoff ikke bestiger 20kHz for å unngå problemer.
  if kCutFreq > 20000 then
    kCutFreq = 20000
  else
    kCutFreq = kCutFreq
  endif

  ;Filter
  aOutL moogladder aOscL, kCutFreq, 0.3
  aOutR moogladder aOscR, kCutFreq, 0.3

  aOutL *= giScale
  aOutR *= giScale

  outleta "OutLeft",  aOutL
  outleta "OutRight", aOutR
endin

;Channel vocoder med stereo output
instr Vocoder
  aMod  inleta "Modulator"
  aCarL inleta "CarrierLeft"
  aCarR inleta "CarrierRight"

  ;Analyser alle input-signalene
  iFFT = 256

  ;Bruker egen stereo-vocoder UDO.
  aOutL, aOutR vocoders aMod, aCarL, aCarR, iFFT

  outleta "OutLeft",  aOutL
  outleta "OutRight", aOutR
endin

;MIDI-trigga freeze-effekt.
instr Freeze
  aL inleta "InLeft"
  aR inleta "InRight"

  ;Bruk en MIDI CC-knapp for å aktivere freeze.
  kEnable ctrl7 giPadsChn, giFreezeCC, 0, 1

  iFFT = 1024
  fAnalyzeL pvsanal aL, iFFT, iFFT/4, iFFT*2, 0
  fAnalyzeR pvsanal aR, iFFT, iFFT/4, iFFT*2, 0

  ;Frys amplitude og pitch
  fFreezeL pvsfreeze fAnalyzeL, kEnable, kEnable
  fFreezeR pvsfreeze fAnalyzeR, kEnable, kEnable

  aResynthL pvsynth fFreezeL
  aResynthR pvsynth fFreezeR

  ;Filterkontroll
  kCutoff ctrl7 giPadsChn, giLPFreezeCC, 0.001, 1

  ;Mekker en eksponensiell kurve for filter cutoff, for litt mer naturlig skalering.
  kCurved expcurve kCutoff, 8
  kCurved *= 20000

  aOutL moogladder aResynthL, kCurved, 0.1
  aOutR moogladder aResynthR, kCurved, 0.1

  ;Kjør lyden som vanlig når den ikke er skrudd på for å gjengi riktig lyd.
  if kEnable = 0 then
    aOutL = aL
    aOutR = aR
  endif

  outleta "OutLeft",  aOutL
  outleta "OutRight", aOutR
endin

;MIDI Arpeggiator
instr Arpeggio
  kRate ctrl7 giKeysChn, giArpRateCC, 1, 20
  kNote, kTrigger midiarp kRate, 3 ;Tilfeldig rekkefølge på arpeggio.

  kCps = cpsmidinn(kNote)

  ;i-event varer like lenge som arp-rate.
  kDur = 1/kRate

  ;Trigger arpeggio-synthen.
  if kTrigger = 1 then
    event "i", "ArpSynth", 0, kDur, kCps
  endif

  SKIP:
endin

;Arpeggio synth med glide mellom hver note
instr ArpSynth

  iInCps cpsmidi
  iAmp ampmidi 1

  ;Unngå ekkel glide på første tone som spilles
  if gkOldCps = 0 then
    gkOldCps = iInCps
    reinit GLIDE
  endif

  GLIDE:
  ;Tegner en linje mellom forrige pitch og ny pitch.
  kCps linseg i(gkOldCps), 0.01, iInCps

  iPhase1 random 0, 1
  iPhase2 random 0, 1
  iPhase3 random 0, 1

  aEnv madsr 0.001, 0.2, 0, 0.01
  aOsc1 oscil iAmp/3, kCps, giHammond, iPhase1
  aOsc2 oscil iAmp/3, kCps, giHammond, iPhase2
  aOsc3 oscil iAmp/3, kCps, giHammond, iPhase3
  aOsc1 *= aEnv
  aOsc2 *= aEnv
  aOsc3 *= aEnv

  aOsc = aOsc1+aOsc2+aOsc3

  kCutoff ctrl7 giKeysChn, giLPArpCC, 0, 1
  kCurved expcurve kCutoff, 8
  kCurved *= 20000

  aOut moogladder aOsc, kCurved, 0.4
  aOut *= giScale

  ;Lagre nåværende pitch som gammel pitch
  gkOldCps = kCps

  outleta "Output",  aOut
endin

instr ArpReverb
  aL inleta "InLeft"
  aR inleta "InRight"

  aRevL, aRevR reverbsc aL, aR, 0.8, 8000

  aRevL *= 0.1
  aRevR *= 0.1

  outleta "OutLeft",  aRevL
  outleta "OutRight", aRevR
endin

;Enkel line/mic input
instr Microphone
  aIn inch 1
  outleta "Output", aIn
endin

;Egen tempoklokke, slik at instrumenter kan hente BPM fra score. (Nyttig hvis man skal teste fra score.)
instr BPM
  iBPM = p4
  tempo p4, 60 ;Sett tempo

  ;Print det nye tempoet til terminalen.
  prints "Current BPM: %d\n", iBPM
endin

;Metronom som ikke går til master
instr Metronome
  iCps cpsmidi
  aEnv madsr 0.001, 0.1, 0, 0.001
  aOut oscil 1, iCps
  aOut *= aEnv
  aOut *= 0.2
  ;outs aOut, aOut
endin

;Master output
instr Master
  aLeft  inleta "InLeft"
  aRight inleta "InRight"

  ;Lyd ut til høyttalere
  outs aLeft, aRight

  ;Skriv WAV-fil til disk.
  fout "render.wav", 14, aLeft, aRight
endin

</CsInstruments>

<CsScore>
;i"BPM" 0 60 60
</CsScore>

</CsoundSynthesizer>
