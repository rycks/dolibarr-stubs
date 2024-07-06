# Dolibarr Stubs Tools (extractor)

[Packagist](https://packagist.org/packages/caprel/dolibarr-stubs)

This package provides tools to extracts stub for [Dolibarr](https://dolibarr.org/)
functions, classes and interfaces.

All of stubs (results) are available on a dedicated repository, all versions of
dolibarr since dolibarr-10.0 are concerned ! [dolibarr-stubs-all]https://github.com/rycks/dolibarr-stubs-all

These stubs can help plugin and theme developers leverage IDE completion
and static analysis tools like [PHPStan](https://github.com/phpstan/phpstan).

The stubs are generated directly from the [source](https://github.com/dolibarr/dolibarr)
using [php-stubs/generator](https://github.com/php-stubs/generator).

## Requirements

- PHP >=7.3

## Installation

Require this package as a development dependency with [Composer](https://getcomposer.org).

```bash
composer require --dev caprel/dolibarr-stubs
```

Alternatively you may download `dolibarr-stubs.php` directly.

## Usage in PHPStan

Include stubs in PHPStan configuration file.

```yaml
parameters:
    bootstrapFiles:
        - vendor/php-stubs/dolibarr-stubs/dolibarr-stubs.php
```

## Support package maintenance

Please consider supporting this work : https://cap-rel.fr/services/soutien-rd/ or [buy me a coffee for example](https://shop.cap-rel.fr/cat/112)


Thank you!


## Thanks to woocommerce-stubs !

This package is based on https://github.com/php-stubs/woocommerce-stubs
