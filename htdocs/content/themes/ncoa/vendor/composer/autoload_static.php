<?php

// autoload_static.php @generated by Composer

namespace Composer\Autoload;

class ComposerStaticInited12ae33f6c6e7718f0a89dd2ba11ee9
{
    public static $prefixLengthsPsr4 = array (
        'D' => 
        array (
            'Dompdf\\' => 7,
        ),
        'C' => 
        array (
            'Composer\\Installers\\' => 20,
        ),
    );

    public static $prefixDirsPsr4 = array (
        'Dompdf\\' => 
        array (
            0 => __DIR__ . '/..' . '/dompdf/dompdf/src',
        ),
        'Composer\\Installers\\' => 
        array (
            0 => __DIR__ . '/..' . '/composer/installers/src/Composer/Installers',
        ),
    );

    public static $prefixesPsr0 = array (
        'S' => 
        array (
            'Svg\\' => 
            array (
                0 => __DIR__ . '/..' . '/phenx/php-svg-lib/src',
            ),
        ),
        'H' => 
        array (
            'Httpful' => 
            array (
                0 => __DIR__ . '/..' . '/nategood/httpful/src',
            ),
        ),
        'F' => 
        array (
            'FontLib\\' => 
            array (
                0 => __DIR__ . '/..' . '/phenx/php-font-lib/src',
            ),
        ),
    );

    public static $classMap = array (
        'Cpdf' => __DIR__ . '/..' . '/dompdf/dompdf/lib/Cpdf.php',
        'HTML5_Data' => __DIR__ . '/..' . '/dompdf/dompdf/lib/html5lib/Data.php',
        'HTML5_InputStream' => __DIR__ . '/..' . '/dompdf/dompdf/lib/html5lib/InputStream.php',
        'HTML5_Parser' => __DIR__ . '/..' . '/dompdf/dompdf/lib/html5lib/Parser.php',
        'HTML5_Tokenizer' => __DIR__ . '/..' . '/dompdf/dompdf/lib/html5lib/Tokenizer.php',
        'HTML5_TreeBuilder' => __DIR__ . '/..' . '/dompdf/dompdf/lib/html5lib/TreeBuilder.php',
    );

    public static function getInitializer(ClassLoader $loader)
    {
        return \Closure::bind(function () use ($loader) {
            $loader->prefixLengthsPsr4 = ComposerStaticInited12ae33f6c6e7718f0a89dd2ba11ee9::$prefixLengthsPsr4;
            $loader->prefixDirsPsr4 = ComposerStaticInited12ae33f6c6e7718f0a89dd2ba11ee9::$prefixDirsPsr4;
            $loader->prefixesPsr0 = ComposerStaticInited12ae33f6c6e7718f0a89dd2ba11ee9::$prefixesPsr0;
            $loader->classMap = ComposerStaticInited12ae33f6c6e7718f0a89dd2ba11ee9::$classMap;

        }, null, ClassLoader::class);
    }
}
