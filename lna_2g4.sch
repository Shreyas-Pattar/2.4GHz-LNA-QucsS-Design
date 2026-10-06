<Qucs Schematic 26.1.1>
<Properties>
  <View=-644,-583,565,185,0.983457,0,0>
  <Grid=10,10,1>
  <DataSet=lna_2g4.dat>
  <DataDisplay=lna_2g4.dpl>
  <OpenDisplay=0>
  <Script=lna_2g4.m>
  <RunScript=0>
  <showFrame=0>
  <FrameText0=Title>
  <FrameText1=Drawn By:>
  <FrameText2=Date:>
  <FrameText3=Revision:>
</Properties>
<Symbol>
</Symbol>
<Components>
  <SPfile X1 1 -300 -400 -26 -63 0 0 "C:/Users/Shreyas Pattar/Documents/Communication Projects/2.4GHz_LNA_QucsS_Design/data/BFP420_2V_5mA.s2p" 1 "polar" 0 "linear" 0 "open" 0 "2" 0>
  <Pac P2 1 -120 -370 18 -26 0 1 "2" 1 "50 Ohm" 1 "0 dBm" 0 "1 MHz" 0 "26.85" 0 "true" 0 "false" 0>
  <.SP SP1 1 -400 -100 0 56 0 0 "lin" 1 "1.5 GHz" 1 "3.5 GHz" 1 "201" 1 "no" 0 "1" 0 "2" 0 "no" 0 "no" 0>
  <Pac P3 1 -590 -370 18 -26 0 1 "1" 1 "50 Ohm" 1 "0 dBm" 0 "1 MHz" 0 "26.85" 0 "true" 0 "false" 0>
  <GND * 1 -300 -370 0 0 0 0>
  <GND * 1 -120 -340 0 0 0 0>
  <Eqn Eqn1 1 -220 -80 -28 18 0 0 "Gain_dB=dB(S[2,1])" 1 "S11_dB=dB(S[1,1])" 1 "S22_dB=dB(S[2,2])" 1 "Delta=S[1,1]*S[2,2] - S[1,2]*S[2,1]" 1 "K=(1 - sqr(abs(S[1,1])) - sqr(abs(S[2,2])) + sqr(abs(Delta))) / (2 * abs(S[1,2]*S[2,1]))" 1 "yes" 0>
  <GND * 1 -590 -340 0 0 0 0>
  <L L1 1 -490 -370 10 -26 0 1 "1.9 nH" 1 "" 0>
  <GND * 1 -490 -340 0 0 0 0>
  <C C1 1 -380 -400 -26 17 0 0 "4.8 pF" 1 "" 0 "neutral" 0>
</Components>
<Wires>
  <-270 -400 -120 -400 "" 0 0 0 "">
  <-590 -400 -490 -400 "" 0 0 0 "">
  <-410 -400 -490 -400 "" 0 0 0 "">
  <-330 -400 -350 -400 "" 0 0 0 "">
</Wires>
<Diagrams>
</Diagrams>
<Paintings>
</Paintings>
