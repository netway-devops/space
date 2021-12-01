<?php

/*
 * Split API.php to separate files, 1 class per file
 * This is to help IDE parse this, Netbens wont touch files bigger than 1 MB
 */
//this is very memory hungry
//better start with  php -d memory_limit=-1

if (php_sapi_name() != "cli") {
    echo "Script has to be executed from cli\n";
    die();
}

$dest = __DIR__ . DIRECTORY_SEPARATOR . 'API';
if (!is_dir($dest)) {
    mkdir($dest);
    if (!is_dir($dest)) {
        echo "Can't create Lib directry\n";
        die();
    }
}

$source = __DIR__ . DIRECTORY_SEPARATOR . 'API.php';
$code = $buffer = $capture = '';
$braces = 0;

function getDocBlock($tokens, $key) {
    $n = count($tokens);
    for ($i = $key; $i > 0; $i--) {
        $token = $tokens[$i];
        if (is_array($token) && $token[0] == T_DOC_COMMENT) {
            return $token[1];
        }
    }
}

$buffer = file_get_contents($source);
$tokens = token_get_all($buffer);
$n = count($tokens);

while ($token = next($tokens)) {
    if ($token[0] == T_CLASS) {
        $capture = true;
        $code = '';
        $name = '';
        $key = key($tokens);
        
        for ($i = $key; $i > 0; $i--) {
            $_token = $tokens[$i];
            if (is_array($_token) && $_token[0] == T_DOC_COMMENT) {
                $code = $_token[1];
                break;
            }
        }
        $code .= "\n" . $token[1];
    } elseif ($capture) {
        if (is_string($token)) {
            $code .= $token;
            if ($token == '{') {
                $braces++;
            } elseif ($token == '}') {
                $braces--;
                if ($braces == 0) {
                    $capture = false;
                    $file = $dest . DIRECTORY_SEPARATOR . $name . '.php';
                    echo $name, "\n";
                    file_put_contents($file, '<?php' . PHP_EOL . $code);
                }
            }
        } else {
            $code .= $token[1];
            
            if ($name == '' && $token[0] == T_STRING) {
                $name = $token[1];
            }
        }
    }
}
$load = <<<PHP
spl_autoload_register(function (\$class) {
    if(stripos(\$class, 'VMware_VCloud_API_') === 0)
        include __DIR__ . DIRECTORY_SEPARATOR .'API' . DIRECTORY_SEPARATOR . \$class . '.php';
});
PHP;
file_put_contents(__DIR__ . DIRECTORY_SEPARATOR . 'API.php', $load);

