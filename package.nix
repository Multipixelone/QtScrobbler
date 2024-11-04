{
  stdenv,
  lib,
  which,
  qttools,
  wrapQtAppsHook,
  qmake,
  qt5,
}:
stdenv.mkDerivation {
  pname = "qtscrob";
  version = "0.11";
  src = ./.;

  nativeBuildInputs = [
    qmake
    wrapQtAppsHook
    qttools
    which
    which
  ];
  buildInputs = [
    qt5.full
  ];

  enableParallelBuilding = true;

  postPatch = ''
    cd src
    sed -i -e "s,/usr/local,$out," -e "s,/usr,," common.pri
  '';

  postFixup = ''
    mkdir -p $out/share/man/man1/
    cp cli/scrobbler.1 $out/share/man/man1
  '';

  meta = with lib; {
    description = "Qt based last.fm scrobbler";
    longDescription = ''
      QTScrobbler is a tool to upload information about the tracks you have played from your Digital Audio Player (DAP) to your last.fm account.
      It is able to gather this information from Apple iPods or DAPs running the Rockbox replacement firmware.
    '';

    homepage = "http://qtscrob.sourceforge.net";
    license = licenses.gpl2;
    maintainers = [maintainers.vanzef];
    platforms = platforms.linux;
  };
}
