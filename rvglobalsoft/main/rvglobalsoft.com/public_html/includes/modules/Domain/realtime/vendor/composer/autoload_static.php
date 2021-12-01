<?php

// autoload_static.php @generated by Composer

namespace Composer\Autoload;

class ComposerStaticInite6adcb8613ac05a7add83948fc0994c1
{
    public static $prefixLengthsPsr4 = array (
        'W' => 
        array (
            'WebSocket\\' => 10,
        ),
    );

    public static $prefixDirsPsr4 = array (
        'WebSocket\\' => 
        array (
            0 => __DIR__ . '/..' . '/textalk/websocket/lib',
        ),
    );

    public static function getInitializer(ClassLoader $loader)
    {
        return \Closure::bind(function () use ($loader) {
            $loader->prefixLengthsPsr4 = ComposerStaticInite6adcb8613ac05a7add83948fc0994c1::$prefixLengthsPsr4;
            $loader->prefixDirsPsr4 = ComposerStaticInite6adcb8613ac05a7add83948fc0994c1::$prefixDirsPsr4;

        }, null, ClassLoader::class);
    }
}
