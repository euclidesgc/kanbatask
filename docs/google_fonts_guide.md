# Google Fonts no KanbaTask

Este projeto está configurado para usar Google Fonts. Aqui estão as informações sobre como usar e configurar fontes.

## Configuração Atual

### Dependências
No `pubspec.yaml`, a dependência `google_fonts` está configurada:
```yaml
dependencies:
  google_fonts: ^6.2.1
```

### Assets
As pastas de assets estão configuradas:
```yaml
assets:
  - assets/images/
  - assets/google_fonts/
```

## Como Usar Google Fonts

### 1. Importar o package
```dart
import 'package:google_fonts/google_fonts.dart';
```

### 2. Aplicar uma fonte específica
```dart
Text(
  'Texto com Roboto',
  style: GoogleFonts.roboto(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  ),
)
```

### 3. Definir tema global
```dart
MaterialApp(
  theme: ThemeData(
    textTheme: GoogleFonts.robotoTextTheme(
      Theme.of(context).textTheme,
    ),
  ),
)
```

## Fontes Populares Disponíveis

- `GoogleFonts.roboto()` - Font padrão do Material Design
- `GoogleFonts.lato()` - Fonte clean e legível
- `GoogleFonts.openSans()` - Fonte humanista popular
- `GoogleFonts.montserrat()` - Fonte geométrica moderna
- `GoogleFonts.poppins()` - Fonte redonda e amigável
- `GoogleFonts.inter()` - Ótima para interfaces
- `GoogleFonts.sourceCodePro()` - Fonte monoespaçada para código

## Cache de Fontes

### Online (Padrão)
As fontes são baixadas automaticamente da API do Google Fonts quando necessário.

### Offline (Opcional)
Para usar fontes offline, você pode:

1. Baixar as fontes desejadas e colocá-las em `assets/google_fonts/`
2. Configurar o package para usar fontes locais:
```dart
GoogleFonts.roboto(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w400,
)
```

## Exemplo de Uso

Veja o arquivo `lib/examples/google_fonts_example.dart` para exemplos completos de como usar diferentes fontes do Google Fonts.

## Vantagens

- ✅ Acesso a centenas de fontes gratuitas
- ✅ Cache automático das fontes
- ✅ Suporte para web, iOS e Android
- ✅ Fallbacks automáticos
- ✅ Integração fácil com Material Design

## Links Úteis

- [Google Fonts](https://fonts.google.com/)
- [Documentação do Package](https://pub.dev/packages/google_fonts)
- [Lista de Fontes Disponíveis](https://fonts.google.com/)
