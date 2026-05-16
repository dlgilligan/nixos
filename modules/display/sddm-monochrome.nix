{ stdenv, fetchFromGitHub }:
stdenv.mkDerivation {
  pname="sddm-monochrome";
  version = "1.0";
  dontBuild = true;
  installPhase = ''
    mkdir -p $out/share/sddm/themes/monochrome
    cp -aR $src/sddm/themes/monochrome/. $out/share/sddm/themes/monochrome
    chmod +w $out/share/sddm/themes/monochrome/theme.conf
    cat << EOF > $out/share/sddm/themes/monochrome/theme.conf
[General]
Font="Unifont"
ClockEnabled="true"
# Must be set to either "left", "right" or "center".
ClockPosition="center"
CustomBackground="false"
LoginBackground="false"
Background="backgrounds/solid-color-image.jpeg"
# Uncomment this option to show the last letter of the password
# for the number of milliseconds specified.
# PasswordShowLastLetter=1000

FontSize=12
# Background colors.
bgDark      = "#181818"
bgDefault   = "#1e1e1e"
# Text colors.
textDefault             = "#ffffff"
textHighlight           = "#ffffff"
textPlaceholder         = "#888888"
# Button colors.
buttonBgNormal          = "#1e1e1e"
buttonBorderNormal      = "#3a3a3a"
buttonBgHovered0        = "#2e2e2e"
buttonBgHovered1        = "#282828"
buttonBorderHovered     = "#555555"
buttonBgPressed         = "#383838"
buttonBorderPressed     = "#555555"
buttonBgFocused0        = "#2e2e2e"
buttonBgFocused1        = "#282828"
buttonBorderFocused     = "#555555"
# LineEdit/Textfield colors.
lineeditBgNormal        = "#1e1e1e"
lineeditBorderNormal    = "#3a3a3a"
lineeditBorderHovered   = "#555555"
lineeditBorderFocused   = "#777777"
# ViewItem/Selection colors.
viewitemBgHovered       = "#282828"
viewitemBorderHovered   = "#444444"
viewitemBgPressed       = "#303030"
viewitemBorderPressed   = "#555555"
# Opacity.
opacityPanel    = "0.95"
opacityDefault  = "0.90"
EOF
  '';
  src = fetchFromGitHub {
    owner = "pwyde";
    repo = "monochrome-kde";
    rev = "7872379532faebf5a0a7fbe58f6acc7fca98ad8b";
    hash = "sha256-w0Z5H4h+53H8MKR80P5152q3SEp3k5lBhjnbhMrg9uM=";
  };
}
