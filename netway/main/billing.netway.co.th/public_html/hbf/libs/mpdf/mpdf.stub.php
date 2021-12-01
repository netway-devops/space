<?php

/**
 * STUB file
 * mpdf.php is to big for IDE to index
 */

define('mPDF_VERSION', '6.1');

//Scale factor
define('_MPDFK', (72 / 25.4));

// Specify which font metrics to use:
// 'winTypo' uses sTypoAscender etc from the OS/2 table and is the one usually recommended - BUT
// 'win' use WinAscent etc from OS/2 and inpractice seems to be used more commonly in Windows environment
// 'mac' uses Ascender etc from hhea table, and is used on Mac/OSX environment
if (!defined('_FONT_DESCRIPTOR')) {
    define("_FONT_DESCRIPTOR", 'win'); // Values: '' [BLANK] or 'win', 'mac', 'winTypo'
}

/* -- HTML-CSS -- */
define('_BORDER_ALL', 15);
define('_BORDER_TOP', 8);
define('_BORDER_RIGHT', 4);
define('_BORDER_BOTTOM', 2);
define('_BORDER_LEFT', 1);
/* -- END HTML-CSS -- */

// mPDF 6.0
// Used for $textvars - user settings via CSS
define('FD_UNDERLINE', 1); // font-decoration
define('FD_LINETHROUGH', 2);
define('FD_OVERLINE', 4);
define('FA_SUPERSCRIPT', 8); // font-(vertical)-align
define('FA_SUBSCRIPT', 16);
define('FT_UPPERCASE', 32); // font-transform
define('FT_LOWERCASE', 64);
define('FT_CAPITALIZE', 128);
define('FC_KERNING', 256); // font-(other)-controls
define('FC_SMALLCAPS', 512);


if (!defined('_MPDF_PATH')) {
    define('_MPDF_PATH', dirname(preg_replace('/\\\\/', '/', __FILE__)) . '/');
}

if (!defined('_MPDF_URI')) {
    define('_MPDF_URI', _MPDF_PATH);
}

if (!defined('_JPGRAPH_PATH')) {
    define("_JPGRAPH_PATH", _MPDF_PATH . 'jpgraph/');
}

if (!defined('_MPDF_TEMP_PATH')) {
    define("_MPDF_TEMP_PATH", _MPDF_PATH . 'tmp/');
}

if (!defined('_MPDF_TTFONTPATH')) {
    define('_MPDF_TTFONTPATH', _MPDF_PATH . 'ttfonts/');
}

if (!defined('_MPDF_TTFONTDATAPATH')) {
    define('_MPDF_TTFONTDATAPATH', _MPDF_PATH . 'ttfontdata/');
}

class mPDF {
    public $useFixedNormalLineHeight;
    public $useFixedTextBaseline;
    public $adjustFontDescLineheight;
    public $interpolateImages;
    public $defaultPagebreakType;
    public $indexUseSubentries;
    public $autoScriptToLang;
    public $baseScript;
    public $autoVietnamese;
    public $autoArabic;
    public $CJKforceend;
    public $h2bookmarks;
    public $h2toc;
    public $decimal_align;
    public $margBuffer;
    public $splitTableBorderWidth;
    public $bookmarkStyles;
    public $useActiveForms;
    public $repackageTTF;
    public $allowCJKorphans;
    public $allowCJKoverflow;
    public $useKerning;
    public $restrictColorSpace;
    public $bleedMargin;
    public $crossMarkMargin;
    public $cropMarkMargin;
    public $cropMarkLength;
    public $nonPrintMargin;
    public $PDFX;
    public $PDFXauto;
    public $PDFA;
    public $PDFAauto;
    public $ICCProfile;
    public $printers_info;
    public $iterationCounter;
    public $smCapsScale;
    public $smCapsStretch;
    public $backupSubsFont;
    public $backupSIPFont;
    public $debugfonts;
    public $useAdobeCJK;
    public $percentSubset;
    public $maxTTFFilesize;
    public $BMPonly;
    public $tableMinSizePriority;
    public $dpi;
    public $watermarkImgAlphaBlend;
    public $watermarkImgBehind;
    public $justifyB4br;
    public $packTableData;
    public $pgsIns;
    public $simpleTables;
    public $enableImports;
    public $debug;
    public $showStats;
    public $setAutoTopMargin;
    public $setAutoBottomMargin;
    public $autoMarginPadding;
    public $collapseBlockMargins;
    public $falseBoldWeight;
    public $normalLineheight;
    public $progressBar;
    public $incrementFPR1;
    public $incrementFPR2;
    public $incrementFPR3;
    public $incrementFPR4;
    public $SHYlang;
    public $SHYleftmin;
    public $SHYrightmin;
    public $SHYcharmin;
    public $SHYcharmax;
    public $SHYlanguages;
    public $pagenumPrefix;
    public $pagenumSuffix;
    public $nbpgPrefix;
    public $nbpgSuffix;
    public $showImageErrors;
    public $allow_output_buffering;
    public $autoPadding;
    public $useGraphs;
    public $tabSpaces;
    public $autoLangToFont;
    public $watermarkTextAlpha;
    public $watermarkImageAlpha;
    public $watermark_size;
    public $watermark_pos;
    public $annotSize;
    public $annotMargin;
    public $annotOpacity;
    public $title2annots;
    public $keepColumns;
    public $keep_table_proportions;
    public $ignore_table_widths;
    public $ignore_table_percents;
    public $list_number_suffix;
    public $list_auto_mode;
    public $list_indent_first_level;
    public $list_indent_default;
    public $list_marker_offset;
    public $useSubstitutions;
    public $CSSselectMedia;
    public $forcePortraitHeaders;
    public $forcePortraitMargins;
    public $displayDefaultOrientation;
    public $ignore_invalid_utf8;
    public $allowedCSStags;
    public $onlyCoreFonts;
    public $allow_charset_conversion;
    public $jSWord;
    public $jSmaxChar;
    public $jSmaxCharLast;
    public $jSmaxWordLast;
    public $max_colH_correction;
    public $table_error_report;
    public $table_error_report_param;
    public $biDirectional;
    public $text_input_as_HTML;
    public $anchor2Bookmark;
    public $shrink_tables_to_fit;
    public $allow_html_optional_endtags;
    public $img_dpi;
    public $defaultheaderfontsize;
    public $defaultheaderfontstyle;
    public $defaultheaderline;
    public $defaultfooterfontsize;
    public $defaultfooterfontstyle;
    public $defaultfooterline;
    public $header_line_spacing;
    public $footer_line_spacing;
    public $pregCJKchars;
    public $pregRTLchars;
    public $pregCURSchars;
    public $mirrorMargins;
    public $watermarkText;
    public $watermarkImage;
    public $showWatermarkText;
    public $showWatermarkImage;
    public $fontsizes;
    public $defaultPageNumStyle;
    public $otl;
    public $cssmgr;
    public $grad;
    public $bmp;
    public $wmf;
    public $tocontents;
    public $mpdfform;
    public $directw;
    public $script2lang;
    public $viet;
    public $pashto;
    public $urdu;
    public $persian;
    public $sindhi;
    public $extrapagebreak;
    public $uniqstr;
    public $hasOC;
    public $textvar;
    public $fontLanguageOverride;
    public $OTLtags;
    public $OTLdata;
    public $writingToC;
    public $layers;
    public $current_layer;
    public $open_layer_pane;
    public $decimal_offset;
    public $inMeter;
    public $CJKleading;
    public $CJKfollowing;
    public $CJKoverflow;
    public $textshadow;
    public $colsums;
    public $spanborder;
    public $spanborddet;
    public $visibility;
    public $useRC128encryption;
    public $uniqid;
    public $kerning;
    public $fixedlSpacing;
    public $minwSpacing;
    public $lSpacingCSS;
    public $wSpacingCSS;
    public $spotColorIDs;
    public $SVGcolors;
    public $spotColors;
    public $defTextColor;
    public $defDrawColor;
    public $defFillColor;
    public $tableBackgrounds;
    public $inlineDisplayOff;
    public $kt_y00;
    public $kt_p00;
    public $upperCase;
    public $checkSIP;
    public $checkSMP;
    public $checkCJK;
    public $watermarkImgAlpha;
    public $PDFAXwarnings;
    public $MetadataRoot;
    public $OutputIntentRoot;
    public $InfoRoot;
    public $current_filename;
    public $parsers;
    public $current_parser;
    public $_obj_stack;
    public $_don_obj_stack;
    public $_current_obj_id;
    public $tpls;
    public $tpl;
    public $tplprefix;
    public $_res;
    public $pdf_version;
    public $noImageFile;
    public $lastblockbottommargin;
    public $baselineC;
    public $baselineSup;
    public $baselineSub;
    public $baselineS;
    public $subPos;
    public $subArrMB;
    public $ReqFontStyle;
    public $tableClipPath;
    public $fullImageHeight;
    public $inFixedPosBlock;
    public $fixedPosBlock;
    public $fixedPosBlockDepth;
    public $fixedPosBlockBBox;
    public $fixedPosBlockSave;
    public $maxPosL;
    public $maxPosR;
    public $loaded;
    public $extraFontSubsets;
    public $docTemplateStart;
    public $time0;
    public $indic;
    public $barcode;
    public $SHYpatterns;
    public $loadedSHYpatterns;
    public $loadedSHYdictionary;
    public $SHYdictionary;
    public $SHYdictionaryWords;
    public $spanbgcolorarray;
    public $default_font;
    public $headerbuffer;
    public $lastblocklevelchange;
    public $nestedtablejustfinished;
    public $linebreakjustfinished;
    public $cell_border_dominance_L;
    public $cell_border_dominance_R;
    public $cell_border_dominance_T;
    public $cell_border_dominance_B;
    public $table_keep_together;
    public $plainCell_properties;
    public $shrin_k1;
    public $outerfilled;
    public $blockContext;
    public $floatDivs;
    public $patterns;
    public $pageBackgrounds;
    public $bodyBackgroundGradient;
    public $bodyBackgroundImage;
    public $bodyBackgroundColor;
    public $writingHTMLheader;
    public $writingHTMLfooter;
    public $angle;
    public $gradients;
    public $kwt_Reference;
    public $kwt_BMoutlines;
    public $kwt_toc;
    public $tbrot_BMoutlines;
    public $tbrot_toc;
    public $col_BMoutlines;
    public $col_toc;
    public $currentGraphId;
    public $graphs;
    public $floatbuffer;
    public $floatmargins;
    public $bullet;
    public $bulletarray;
    public $currentLang;
    public $default_lang;
    public $default_available_fonts;
    public $pageTemplate;
    public $docTemplate;
    public $docTemplateContinue;
    public $arabGlyphs;
    public $arabHex;
    public $persianGlyphs;
    public $persianHex;
    public $arabVowels;
    public $arabPrevLink;
    public $arabNextLink;
    public $formobjects;
    public $InlineProperties;
    public $InlineAnnots;
    public $InlineBDF;
    public $InlineBDFctr;
    public $ktAnnots;
    public $tbrot_Annots;
    public $kwt_Annots;
    public $columnAnnots;
    public $columnForms;
    public $PageAnnots;
    public $pageDim;
    public $breakpoints;
    public $tableLevel;
    public $tbctr;
    public $innermostTableLevel;
    public $saveTableCounter;
    public $cellBorderBuffer;
    public $saveHTMLFooter_height;
    public $saveHTMLFooterE_height;
    public $firstPageBoxHeader;
    public $firstPageBoxHeaderEven;
    public $firstPageBoxFooter;
    public $firstPageBoxFooterEven;
    public $page_box;
    public $show_marks;
    public $basepathIsLocal;
    public $use_kwt;
    public $kwt;
    public $kwt_height;
    public $kwt_y0;
    public $kwt_x0;
    public $kwt_buffer;
    public $kwt_Links;
    public $kwt_moved;
    public $kwt_saved;
    public $PageNumSubstitutions;
    public $table_borders_separate;
    public $base_table_properties;
    public $borderstyles;
    public $blockjustfinished;
    public $orig_bMargin;
    public $orig_tMargin;
    public $orig_lMargin;
    public $orig_rMargin;
    public $orig_hMargin;
    public $orig_fMargin;
    public $pageHTMLheaders;
    public $pageHTMLfooters;
    public $saveHTMLHeader;
    public $saveHTMLFooter;
    public $HTMLheaderPageLinks;
    public $HTMLheaderPageAnnots;
    public $HTMLheaderPageForms;
    public $available_unifonts;
    public $sans_fonts;
    public $serif_fonts;
    public $mono_fonts;
    public $defaultSubsFont;
    public $available_CJK_fonts;
    public $HTMLHeader;
    public $HTMLFooter;
    public $HTMLHeaderE;
    public $HTMLFooterE;
    public $bufferoutput;
    public $Big5_widths;
    public $GB_widths;
    public $SJIS_widths;
    public $UHC_widths;
    public $encrypted;
    public $Uvalue;
    public $Ovalue;
    public $Pvalue;
    public $enc_obj_id;
    public $last_rc4_key;
    public $last_rc4_key_c;
    public $encryption_key;
    public $padding;
    public $BMoutlines;
    public $OutlineRoot;
    public $ColActive;
    public $Reference;
    public $CurrCol;
    public $NbCol;
    public $y0;
    public $ColL;
    public $ColWidth;
    public $ColGap;
    public $ColR;
    public $ChangeColumn;
    public $columnbuffer;
    public $ColDetails;
    public $columnLinks;
    public $colvAlign;
    public $substitute;
    public $entsearch;
    public $entsubstitute;
    public $defaultCSS;
    public $lastoptionaltag;
    public $pageoutput;
    public $charset_in;
    public $blk;
    public $blklvl;
    public $ColumnAdjust;
    public $ws;
    public $HREF;
    public $pgwidth;
    public $fontlist;
    public $oldx;
    public $oldy;
    public $B;
    public $I;
    public $tdbegin;
    public $table;
    public $cell;
    public $col;
    public $row;
    public $divbegin;
    public $divwidth;
    public $divheight;
    public $spanbgcolor;
    public $cellTextAlign;
    public $cellLineHeight;
    public $cellLineStackingStrategy;
    public $cellLineStackingShift;
    public $listcounter;
    public $listlvl;
    public $listtype;
    public $listitem;
    public $pjustfinished;
    public $ignorefollowingspaces;
    public $SMALL;
    public $BIG;
    public $dash_on;
    public $dotted_on;
    public $textbuffer;
    public $currentfontstyle;
    public $currentfontfamily;
    public $currentfontsize;
    public $colorarray;
    public $bgcolorarray;
    public $internallink;
    public $enabledtags;
    public $lineheight;
    public $basepath;
    public $textparam;
    public $specialcontent;
    public $selectoption;
    public $objectbuffer;
    public $table_rotate;
    public $tbrot_maxw;
    public $tbrot_maxh;
    public $tablebuffer;
    public $tbrot_align;
    public $tbrot_Links;
    public $keep_block_together;
    public $tbrot_y0;
    public $tbrot_x0;
    public $tbrot_w;
    public $tbrot_h;
    public $mb_enc;
    public $directionality;
    public $extgstates;
    public $mgl;
    public $mgt;
    public $mgr;
    public $mgb;
    public $tts;
    public $ttz;
    public $tta;
    public $page_break_after_avoid;
    public $margin_bottom_collapse;
    public $default_font_size;
    public $original_default_font_size;
    public $original_default_font;
    public $watermark_font;
    public $defaultAlign;
    public $defaultTableAlign;
    public $tablethead;
    public $thead_font_weight;
    public $thead_font_style;
    public $thead_font_smCaps;
    public $thead_valign_default;
    public $thead_textalign_default;
    public $tabletfoot;
    public $tfoot_font_weight;
    public $tfoot_font_style;
    public $tfoot_font_smCaps;
    public $tfoot_valign_default;
    public $tfoot_textalign_default;
    public $trow_text_rotate;
    public $cellPaddingL;
    public $cellPaddingR;
    public $cellPaddingT;
    public $cellPaddingB;
    public $table_border_attr_set;
    public $table_border_css_set;
    public $shrin_k;
    public $shrink_this_table_to_fit;
    public $MarginCorrection;
    public $margin_footer;
    public $margin_header;
    public $tabletheadjustfinished;
    public $usingCoreFont;
    public $charspacing;
    public $DisplayPreferences;
    public $flowingBlockAttr;
    public $page;
    public $n;
    public $offsets;
    public $buffer;
    public $pages;
    public $state;
    public $compress;
    public $DefOrientation;
    public $CurOrientation;
    public $OrientationChanges;
    public $k;
    public $fwPt;
    public $fhPt;
    public $fw;
    public $fh;
    public $wPt;
    public $hPt;
    public $w;
    public $h;
    public $lMargin;
    public $tMargin;
    public $rMargin;
    public $bMargin;
    public $cMarginL;
    public $cMarginR;
    public $cMarginT;
    public $cMarginB;
    public $DeflMargin;
    public $DefrMargin;
    public $x;
    public $y;
    public $lasth;
    public $LineWidth;
    public $CoreFonts;
    public $fonts;
    public $FontFiles;
    public $images;
    public $PageLinks;
    public $links;
    public $FontFamily;
    public $FontStyle;
    public $CurrentFont;
    public $FontSizePt;
    public $FontSize;
    public $DrawColor;
    public $FillColor;
    public $TextColor;
    public $ColorFlag;
    public $autoPageBreak;
    public $PageBreakTrigger;
    public $InFooter;
    public $InHTMLFooter;
    public $processingFooter;
    public $processingHeader;
    public $ZoomMode;
    public $LayoutMode;
    public $title;
    public $subject;
    public $author;
    public $keywords;
    public $creator;
    public $aliasNbPg;
    public $aliasNbPgGp;
    public $ispre;
    public $outerblocktags;
    public $innerblocktags;

    public function __construct($mode = '', $format = 'A4', $default_font_size = 0, $default_font = '', $mgl = 15, $mgr = 15, $mgt = 16, $mgb = 16, $mgh = 9, $mgf = 9, $orientation = 'P') {
    }

    public function _setPageSize($format, $orientation) {
    }

    public function _getPageFormat($format) {
    }

    public function StartProgressBarOutput($mode = 1) {
    }

    public function UpdateProgressBar($el, $val, $txt = '') {
    }

    public function RestrictUnicodeFonts($res) {
    }

    public function setMBencoding($enc) {
    }

    public function SetMargins($left, $right, $top) {
    }

    public function ResetMargins() {
    }

    public function SetLeftMargin($margin) {
    }

    public function SetTopMargin($margin) {
    }

    public function SetRightMargin($margin) {
    }

    public function SetAutoPageBreak($auto, $margin = 0) {
    }

    public function SetDisplayMode($zoom, $layout = 'continuous') {
    }

    public function SetCompression($compress) {
    }

    public function SetTitle($title) {
    }

    public function SetSubject($subject) {
    }

    public function SetAuthor($author) {
    }

    public function SetKeywords($keywords) {
    }

    public function SetCreator($creator) {
    }

    public function SetAnchor2Bookmark($x) {
    }

    public function AliasNbPages($alias = '{nb}') {
    }

    public function AliasNbPageGroups($alias = '{nbpg}') {
    }

    public function SetAlpha($alpha, $bm = 'Normal', $return = false, $mode = 'B') {
    }

    public function AddExtGState($parms) {
    }

    public function SetVisibility($v) {
    }

    public function Open() {
    }

    public function AddPages($a = '', $b = '', $c = '', $d = '', $e = '', $f = '', $g = '', $h = '', $i = '', $j = '', $k = '', $l = '', $m = '', $n = '', $o = '', $p = 0, $q = 0, $r = 0, $s = 0, $t = '', $u = '') {
    }

    public function startPageNums() {
    }

    public function setUnvalidatedText($a = '', $b = -1) {
    }

    public function SetAutoFont($a) {
    }

    public function Reference($a) {
    }

    public function ReferenceSee($a, $b) {
    }

    public function CreateReference($a = 1, $b = '', $c = '', $d = 3, $e = 1, $f = '', $g = 5, $h = '', $i = '', $j = false) {
    }

    public function CreateIndex($a = 1, $b = '', $c = '', $d = 3, $e = 1, $f = '', $g = 5, $h = '', $i = '', $j = false) {
    }

    public function Close() {
    }

    public function _resizeBackgroundImage($imw, $imh, $cw, $ch, $resize = 0, $repx, $repy, $pba = array(), $size = array()) {
    }

    public function SetBackground($properties, $maxwidth) {
    }

    public function PrintBodyBackgrounds() {
    }

    public function _setClippingPath($clx, $cly, $clw, $clh) {
    }

    public function PrintPageBackgrounds($adjustmenty = 0) {
    }

    public function PrintTableBackgrounds($adjustmenty = 0) {
    }

    public function BeginLayer($id) {
    }

    public function EndLayer() {
    }

    public function AddPageByArray($a) {
    }

    public function _preForcedPagebreak($pagebreaktype) {
    }

    public function _postForcedPagebreak($pagebreaktype, $startpage, $save_blk, $save_blklvl) {
    }

    public function AddPage($orientation = '', $condition = '', $resetpagenum = '', $pagenumstyle = '', $suppress = '', $mgl = '', $mgr = '', $mgt = '', $mgb = '', $mgh = '', $mgf = '', $ohname = '', $ehname = '', $ofname = '', $efname = '', $ohvalue = 0, $ehvalue = 0, $ofvalue = 0, $efvalue = 0, $pagesel = '', $newformat = '') {
    }

    public function PageNo() {
    }

    public function AddSpotColorsFromFile($file) {
    }

    public function AddSpotColor($name, $c, $m, $y, $k) {
    }

    public function SetColor($col, $type = '') {
    }

    public function SetDColor($col, $return = false) {
    }

    public function SetFColor($col, $return = false) {
    }

    public function SetTColor($col, $return = false) {
    }

    public function SetDrawColor($r, $g = -1, $b = -1, $col4 = -1, $return = false) {
    }

    public function SetFillColor($r, $g = -1, $b = -1, $col4 = -1, $return = false) {
    }

    public function SetTextColor($r, $g = -1, $b = -1, $col4 = -1, $return = false) {
    }

    public function _getCharWidth($cw, $u, $isdef = true) {
    }

    public function _charDefined($cw, $u) {
    }

    public function GetCharWidthCore($c) {
    }

    public function GetCharWidthNonCore($c, $addSubset = true) {
    }

    public function GetCharWidth($c, $addSubset = true) {
    }

    public function GetStringWidth($s, $addSubset = true, $OTLdata = false, $textvar = 0, $includeKashida = false) {
    }

    public function SetLineWidth($width) {
    }

    public function Line($x1, $y1, $x2, $y2) {
    }

    public function Arrow($x1, $y1, $x2, $y2, $headsize = 3, $fill = 'B', $angle = 25) {
    }

    public function Rect($x, $y, $w, $h, $style = '') {
    }

    public function AddFont($family, $style = '') {
    }

    public function SetFont($family, $style = '', $size = 0, $write = true, $forcewrite = false) {
    }

    public function SetFontSize($size, $write = true) {
    }

    public function AddLink() {
    }

    public function SetLink($link, $y = 0, $page = -1) {
    }

    public function Link($x, $y, $w, $h, $link) {
    }

    public function Text($x, $y, $txt, $OTLdata = array(), $textvar = 0, $aixextra = '', $coordsys = '', $return = false) {
    }

    public function WriteText($x, $y, $txt) {
    }

    public function WriteCell($w, $h = 0, $txt = '', $border = 0, $ln = 0, $align = '', $fill = 0, $link = '', $currentx = 0) {
    }

    public function ResetSpacing() {
    }

    public function SetSpacing($cs, $ws) {
    }

    public function GetJspacing($nc, $ns, $w, $inclCursive, $cOTLdata) {
    }

    public function Cell($w, $h = 0, $txt = '', $border = 0, $ln = 0, $align = '', $fill = 0, $link = '', $currentx = 0, $lcpaddingL = 0, $lcpaddingR = 0, $valign = 'M', $spanfill = 0, $exactWidth = false, $OTLdata = false, $textvar = 0, $lineBox = false) {
    }

    public function applyGPOSpdf($txt, $aix, $x, $y, $OTLdata, $textvar = 0) {
    }

    public function _kern($txt, $mode, $aix, $x, $y) {
    }

    public function MultiCell($w, $h, $txt, $border = 0, $align = '', $fill = 0, $link = '', $directionality = 'ltr', $encoded = false, $OTLdata = false, $maxrows = false) {
    }

    public function Write($h, $txt, $currentx = 0, $link = '', $directionality = 'ltr', $align = '') {
    }

    public function saveInlineProperties() {
    }

    public function restoreInlineProperties($saved) {
    }

    public function GetFirstBlockFill() {
    }

    public function saveFont() {
    }

    public function restoreFont($saved, $write = true) {
    }

    public function newFlowingBlock($w, $h, $a = '', $is_table = false, $blockstate = 0, $newblock = true, $blockdir = 'ltr', $table_draft = false) {
    }

    public function finishFlowingBlock($endofblock = false, $next = '') {
    }

    public function printobjectbuffer($is_table = false, $blockdir = false) {
    }

    public function _printListBullet($x, $y, $size, $type, $color) {
    }

    public function _moveToPrevChar($contentctr, $charctr, $content) {
    }

    public function _getPrevChar($contentctr, $charctr, $content) {
    }

    public function WriteFlowingBlock($s, $sOTLdata) {
    }

    public function _advanceFloatMargins() {
    }

    public function _SetTextRendering($mode) {
    }

    public function SetTextOutline($params = array()) {
    }

    public function Image($file, $x, $y, $w = 0, $h = 0, $type = '', $link = '', $paint = true, $constrain = true, $watermark = false, $shownoimg = true, $allowvector = true) {
    }

    public function _getObjAttr($t) {
    }

    public function inlineObject($type, $x, $y, $objattr, $Lmargin, $widthUsed, $maxWidth, $lineHeight, $paint = false, $is_table = false) {
    }

    public function SetLineJoin($mode = 0) {
    }

    public function SetLineCap($mode = 2) {
    }

    public function SetDash($black = false, $white = false) {
    }

    public function SetDisplayPreferences($preferences) {
    }

    public function Ln($h = '', $collapsible = 0) {
    }

    public function DivLn($h, $level = -3, $move_y = true, $collapsible = false, $state = 0) {
    }

    public function SetX($x) {
    }

    public function SetY($y) {
    }

    public function SetXY($x, $y) {
    }

    public function Output($name = '', $dest = '') {
    }

    public function _dochecks() {
    }

    public function _puthtmlheaders() {
    }

    public function _putpages() {
    }

    public function _putannots() {
    }

    public function Annotation($text, $x = 0, $y = 0, $icon = 'Note', $author = '', $subject = '', $opacity = 0, $colarray = false, $popup = '', $file = '') {
    }

    public function _putfonts() {
    }

    public function _putTTfontwidths($font, $asSubset, $maxUni) {
    }

    public function _putfontranges($range) {
    }

    public function _putfontwidths($font, $cidoffset = 0) {
    }

    public function _putType0($font) {
    }

    public function _putimages() {
    }

    public function _putinfo() {
    }

    public function _putmetadata() {
    }

    public function _putoutputintent() {
    }

    public function _putcatalog() {
    }

    public function SetUserRights($enable = true, $annots = '', $form = '', $signature = '') {
    }

    public function _enddoc() {
    }

    public function _beginpage($orientation, $mgl = '', $mgr = '', $mgt = '', $mgb = '', $mgh = '', $mgf = '', $ohname = '', $ehname = '', $ofname = '', $efname = '', $ohvalue = 0, $ehvalue = 0, $ofvalue = 0, $efvalue = 0, $pagesel = '', $newformat = '') {
    }

    public function _setAutoHeaderHeight($htmlh) {
    }

    public function _setAutoFooterHeight($htmlf) {
    }

    public function _endpage() {
    }

    public function _newobj($obj_id = false, $onlynewobj = false) {
    }

    public function _dounderline($x, $y, $txt, $OTLdata = false, $textvar = 0) {
    }

    public function _imageError($file, $firsttime, $msg) {
    }

    public function _getImage($file, $firsttime = true, $allowvector = true, $orig_srcpath = false, $interpolation = false) {
    }

    public function _convImage($data, $colspace, $targetcs, $w, $h, $dpi, $mask, $gamma_correction = false, $pngcolortype = false) {
    }

    public function _trnsvalue($s, $bpc) {
    }

    public function _fourbytes2int($s) {
    }

    public function _twobytes2int($s) {
    }

    public function _jpgHeaderFromString($data) {
    }

    public function _jpgDataFromHeader($hdr) {
    }

    public function file_get_contents_by_curl($url, $data) {
    }

    public function file_get_contents_by_socket($url, $data) {
    }

    public function _imageTypeFromString($data) {
    }

    public function _putformobjects() {
    }

    public function _freadint($f) {
    }

    public function _UTF16BEtextstring($s) {
    }

    public function _textstring($s) {
    }

    public function _escape($s) {
    }

    public function _putstream($s) {
    }

    public function _out($s, $ln = true) {
    }

    public function watermark($texte, $angle = 45, $fontsize = 96, $alpha = 0.20000000000000001) {
    }

    public function watermarkImg($src, $alpha = 0.20000000000000001) {
    }

    public function Rotate($angle, $x = -1, $y = -1) {
    }

    public function CircularText($x, $y, $r, $text, $align = 'top', $fontfamily = '', $fontsize = 0, $fontstyle = '', $kerning = 120, $fontwidth = 100, $divider) {
    }

    public function RoundedRect($x, $y, $w, $h, $r, $style = '') {
    }

    public function _Arc($x1, $y1, $x2, $y2, $x3, $y3) {
    }

    public function Shaded_box($text, $font = '', $fontstyle = 'B', $szfont = '', $width = '70%', $style = 'DF', $radius = 2.5, $fill = '#FFFFFF', $color = '#000000', $pad = 2) {
    }

    public function UTF8StringToArray($str, $addSubset = true) {
    }

    public function UTF8toSubset($str) {
    }

    public function UTF8ToUTF16BE($str, $setbom = true) {
    }

    public function AddCIDFont($family, $style, $name, $cw, $CMap, $registry, $desc) {
    }

    public function AddCJKFont($family) {
    }

    public function AddBig5Font() {
    }

    public function AddGBFont() {
    }

    public function AddSJISFont() {
    }

    public function AddUHCFont() {
    }

    public function SetDefaultFont($font) {
    }

    public function SetDefaultFontSize($fontsize) {
    }

    public function SetDefaultBodyCSS($prop, $val) {
    }

    public function SetDirectionality($dir = 'ltr') {
    }

    public function fixLineheight($v) {
    }

    public function _getNormalLineheight($desc = false) {
    }

    public function SetLineHeight($FontPt = '', $lh = '') {
    }

    public function _computeLineheight($lh, $fs = '') {
    }

    public function _setLineYpos($fontsize, $fontdesc, $CSSlineheight, $blockYpos = false) {
    }

    public function _setInlineBlockHeights($lineBox, $stackHeight, $content, $font, $is_table) {
    }

    public function SetBasePath($str = '') {
    }

    public function GetFullPath($path, $basepath = '') {
    }

    public function _get_file($path) {
    }

    public function docPageNum($num = 0, $extras = false) {
    }

    public function docPageNumTotal($num = 0, $extras = false) {
    }

    public function _getStyledNumber($ppgno, $type, $listmarker = false) {
    }

    public function docPageSettings($num = 0) {
    }

    public function RestartDocTemplate() {
    }

    public function Header($content = '') {
    }

    public function TableHeaderFooter($content = '', $tablestartpage = '', $tablestartcolumn = '', $horf = 'H', $level, $firstSpread = true, $finalSpread = true) {
    }

    public function SetHTMLHeader($header = '', $OE = '', $write = false) {
    }

    public function SetHTMLFooter($footer = '', $OE = '') {
    }

    public function _getHtmlHeight($html) {
    }

    public function writeHTMLHeaders() {
    }

    public function writeHTMLFooters() {
    }

    public function _shareHeaderFooterWidth($cl, $cc, $cr) {
    }

    public function _createHTMLheaderFooter($arr, $hf) {
    }

    public function DefHeaderByName($name, $arr) {
    }

    public function DefFooterByName($name, $arr) {
    }

    public function SetHeaderByName($name, $side = 'O', $write = false) {
    }

    public function SetFooterByName($name, $side = 'O') {
    }

    public function DefHTMLHeaderByName($name, $html) {
    }

    public function DefHTMLFooterByName($name, $html) {
    }

    public function SetHTMLHeaderByName($name, $side = 'O', $write = false) {
    }

    public function SetHTMLFooterByName($name, $side = 'O') {
    }

    public function SetHeader($Harray = array(), $side = '', $write = false) {
    }

    public function SetFooter($Farray = array(), $side = '') {
    }

    public function SetWatermarkText($txt = '', $alpha = -1) {
    }

    public function SetWatermarkImage($src, $alpha = -1, $size = 'D', $pos = 'F') {
    }

    public function Footer() {
    }

    public function hyphenateWord($word, $currptr) {
    }

    public function WriteHTML($html, $sub = 0, $init = true, $close = true) {
    }

    public function WriteFixedPosHTML($html = '', $x, $y, $w, $h, $overflow = 'visible', $bounding = array()) {
    }

    public function initialiseBlock($blk) {
    }

    public function border_details($bd) {
    }

    public function _borderPadding($a, $b, $px, $py) {
    }

    public function SetPagedMediaCSS($name = '', $first, $oddEven) {
    }

    public function ClearFloats($clear, $blklvl = 0) {
    }

    public function GetFloatDivInfo($blklvl = 0, $clear = false) {
    }

    public function _setListMarker($listitemtype, $listitemimage, $listitemposition) {
    }

    public function _getListMarkerWidth($currblk, $a, $i) {
    }

    public function tbsqrt($val, $iteration = 3) {
    }

    public function _saveTextBuffer($t, $link = '', $intlink = '', $return = false) {
    }

    public function _saveCellTextBuffer($t, $link = '', $intlink = '') {
    }

    public function printbuffer($arrayaux, $blockstate = 0, $is_table = false, $table_draft = false, $cell_dir = '') {
    }

    public function _setDashBorder($style, $div, $cp, $side) {
    }

    public function _setBorderLine($b, $k = 1) {
    }

    public function PaintDivBB($divider = '', $blockstate = 0, $blvl = 0) {
    }

    public function _EllipseArc($x0, $y0, $rx, $ry, $seg = 1, $part = false, $start = false) {
    }

    public function PaintDivLnBorder($state = 0, $blvl = 0, $h) {
    }

    public function PaintImgBorder($objattr, $is_table) {
    }

    public function Reset() {
    }

    public function ReadMetaTags($html) {
    }

    public function ReadCharset($html) {
    }

    public function setCSS($arrayaux, $type = '', $tag = '') {
    }

    public function SetStyle($tag, $enable) {
    }

    public function SetStylesArray($arr) {
    }

    public function SetStyles($str) {
    }

    public function ResetStyles() {
    }

    public function DisableTags($str = '') {
    }

    public function TableCheckMinWidth($maxwidth, $forcewrap = 0, $textbuffer, $checkletter = false) {
    }

    public function shrinkTable($table, $k) {
    }

    public function read_short($fh) {
    }

    public function _packCellBorder($cell) {
    }

    public function _getBorderWidths($bindata) {
    }

    public function _unpackCellBorder($bindata) {
    }

    public function _tableColumnWidth($table, $firstpass = false) {
    }

    public function _tableWidth($table) {
    }

    public function _tableHeight($table) {
    }

    public function _tableGetWidth($table, $i, $j) {
    }

    public function _splitTableGetWidth($table, $i, $j) {
    }

    public function _tableGetHeight($table, $i, $j) {
    }

    public function _tableGetMaxRowHeight($table, $row) {
    }

    public function _tableRect($x, $y, $w, $h, $bord = -1, $details = array(), $buffer = false, $bSeparate = false, $cort = 'cell', $tablecorner = '', $bsv = 0, $bsh = 0) {
    }

    public function _lightenColor($c) {
    }

    public function _darkenColor($c) {
    }

    public function setBorder($var, $flag, $set = true) {
    }

    public function issetBorder($var, $flag) {
    }

    public function _table2cellBorder($tableb, $cbdb, $cellb, $bval) {
    }

    public function _fixTableBorders($table) {
    }

    public function _reverseTableDir($table) {
    }

    public function _tableWrite($table, $split = false, $startrow = 0, $startcol = 0, $splitpg = 0, $rety = 0) {
    }

    public function _putextgstates() {
    }

    public function _putocg() {
    }

    public function _putimportedobjects() {
    }

    public function _putformxobjects() {
    }

    public function _putpatterns() {
    }

    public function _putshaders() {
    }

    public function _putspotcolors() {
    }

    public function _putresources() {
    }

    public function _putjavascript() {
    }

    public function _putencryption() {
    }

    public function _puttrailer() {
    }

    public function SetProtection($permissions = array(), $user_pass = '', $owner_pass = NULL, $length = 40) {
    }

    public function _objectkey($n) {
    }

    public function _RC4($key, $text) {
    }

    public function _md5_16($string) {
    }

    public function _Ovalue($user_pass, $owner_pass) {
    }

    public function _Uvalue() {
    }

    public function _generateencryptionkey($user_pass, $owner_pass, $protection) {
    }

    public function _hexToString($hs) {
    }

    public function Bookmark($txt, $level = 0, $y = 0) {
    }

    public function _putbookmarks() {
    }

    public function TOC($tocfont = '', $tocfontsize = 0, $tocindent = 0, $resetpagenum = '', $pagenumstyle = '', $suppress = '', $toc_orientation = '', $TOCusePaging = true, $TOCuseLinking = false, $toc_id = 0, $tocoutdent = '') {
    }

    public function TOCpagebreakByArray($a) {
    }

    public function TOCpagebreak($tocfont = '', $tocfontsize = '', $tocindent = '', $TOCusePaging = true, $TOCuseLinking = '', $toc_orientation = '', $toc_mgl = '', $toc_mgr = '', $toc_mgt = '', $toc_mgb = '', $toc_mgh = '', $toc_mgf = '', $toc_ohname = '', $toc_ehname = '', $toc_ofname = '', $toc_efname = '', $toc_ohvalue = 0, $toc_ehvalue = 0, $toc_ofvalue = 0, $toc_efvalue = 0, $toc_preHTML = '', $toc_postHTML = '', $toc_bookmarkText = '', $resetpagenum = '', $pagenumstyle = '', $suppress = '', $orientation = '', $mgl = '', $mgr = '', $mgt = '', $mgb = '', $mgh = '', $mgf = '', $ohname = '', $ehname = '', $ofname = '', $efname = '', $ohvalue = 0, $ehvalue = 0, $ofvalue = 0, $efvalue = 0, $toc_id = 0, $pagesel = '', $toc_pagesel = '', $sheetsize = '', $toc_sheetsize = '', $tocoutdent = '') {
    }

    public function TOC_Entry($txt, $level = 0, $toc_id = 0) {
    }

    public function MovePages($target_page, $start_page, $end_page = -1) {
    }

    public function DeletePages($start_page, $end_page = -1) {
    }

    public function IndexEntry($txt, $xref = '') {
    }

    public function IndexEntrySee($txta, $txtb) {
    }

    public function InsertIndex($usedivletters = 1, $useLinking = false, $indexCollationLocale = '', $indexCollationGroup = '') {
    }

    public function AcceptPageBreak() {
    }

    public function SetColumns($NbCol, $vAlign = '', $gap = 5) {
    }

    public function SetCol($CurrCol) {
    }

    public function AddColumn() {
    }

    public function NewColumn() {
    }

    public function printcolumnbuffer() {
    }

    public function columnAdjustPregReplace($type, $xadj, $yadj, $pattern, $subject) {
    }

    public function printcellbuffer() {
    }

    public function printtablebuffer() {
    }

    public function printkwtbuffer() {
    }

    public function printfloatbuffer() {
    }

    public function Circle($x, $y, $r, $style = 'S') {
    }

    public function Ellipse($x, $y, $rx, $ry, $style = 'S') {
    }

    public function AutosizeText($text, $w, $font, $style, $szfont = 72) {
    }

    public function magic_reverse_dir($chunk, $dir, $chunkOTLdata) {
    }

    public function getBasicOTLdata($chunkOTLdata, $unicode, $is_strong) {
    }

    public function _setBidiCodes($mode = 'start', $bdf) {
    }

    public function SetSubstitutions() {
    }

    public function SubstituteChars($html) {
    }

    public function SubstituteCharsSIP($writehtml_a, $writehtml_i, $writehtml_e) {
    }

    public function SubstituteCharsNonCore($writehtml_a, $writehtml_i, $writehtml_e) {
    }

    public function SubstituteCharsMB($writehtml_a, $writehtml_i, $writehtml_e) {
    }

    public function setHiEntitySubstitutions() {
    }

    public function SubstituteHiEntities($html) {
    }

    public function is_utf8($string) {
    }

    public function purify_utf8($html, $lo = true) {
    }

    public function purify_utf8_text($txt) {
    }

    public function all_entities_to_utf8($txt) {
    }

    public function WriteBarcode($code, $showtext = 1, $x = '', $y = '', $size = 1, $border = 0, $paddingL = 1, $paddingR = 1, $paddingT = 2, $paddingB = 2, $height = 1, $bgcol = false, $col = false, $btype = 'ISBN', $supplement = '0', $supplement_code = '', $k = 1) {
    }

    public function WriteBarcode2($code, $x = '', $y = '', $size = 1, $height = 1, $bgcol = false, $col = false, $btype = 'IMB', $print_ratio = '', $k = 1) {
    }

    public function StartTransform($returnstring = false) {
    }

    public function StopTransform($returnstring = false) {
    }

    public function transformScale($s_x, $s_y, $x = '', $y = '', $returnstring = false) {
    }

    public function transformTranslate($t_x, $t_y, $returnstring = false) {
    }

    public function transformRotate($angle, $x = '', $y = '', $returnstring = false) {
    }

    public function transformSkew($angle_x, $angle_y, $x = '', $y = '', $returnstring = false) {
    }

    public function _transform($tm, $returnstring = false) {
    }

    public function markScriptToLang($html) {
    }

    public function _cmpdom($a, $b) {
    }

    public function mb_strrev($str, $enc = 'utf-8') {
    }

    public function columnAdjustAdd($type, $k, $xadj, $yadj, $a, $b, $c = 0, $d = 0, $e = 0, $f = 0) {
    }

    public function ConvertColor($color = '#000000') {
    }

    public function rgb2gray($c) {
    }

    public function cmyk2gray($c) {
    }

    public function rgb2cmyk($c) {
    }

    public function cmyk2rgb($c) {
    }

    public function rgb2hsl($var_r, $var_g, $var_b) {
    }

    public function hsl2rgb($h2, $s2, $l2) {
    }

    public function hue_2_rgb($v1, $v2, $vh) {
    }

    public function _invertColor($cor) {
    }

    public function _colAtoString($cor) {
    }

    public function ConvertSize($size = 5, $maxsize = 0, $fontsize = false, $usefontsize = true) {
    }

    public function ConvertAngle($s, $makepositive = true) {
    }

    public function lesser_entity_decode($html) {
    }

    public function AdjustHTML($html, $tabSpaces = 8) {
    }

    public function tabs2spaces_callback($matches) {
    }

    public function date_callback($matches) {
    }

    public function dec2other($num, $cp, $check = true) {
    }

    public function dec2cjk($num) {
    }

    public function dec2alpha($valor, $toupper = 'true') {
    }

    public function dec2hebrew($in, $reverse = false) {
    }

    public function dec2roman($valor, $toupper = true) {
    }

    public function SetImportUse() {
    }

    public function hex2str($hex) {
    }

    public function str2hex($str) {
    }

    public function pdf_write_value($value) {
    }

    public function OverWrite($file_in, $search, $replacement, $dest = 'D', $file_out = 'mpdf') {
    }

    public function GetTemplateSize($tplidx, $_w = 0, $_h = 0) {
    }

    public function Thumbnail($file, $npr = 3, $spacing = 10) {
    }

    public function SetSourceFile($filename) {
    }

    public function ImportPage($pageno = 1, $crop_x = NULL, $crop_y = NULL, $crop_w = 0, $crop_h = 0, $boxName = '/CropBox') {
    }

    public function UseTemplate($tplidx, $_x = NULL, $_y = NULL, $_w = 0, $_h = 0) {
    }

    public function SetPageTemplate($tplidx = '') {
    }

    public function SetDocTemplate($file = '', $continue = 0) {
    }

    public function _set_object_javascript($string) {
    }

    public function SetJS($script) {
    }
}
