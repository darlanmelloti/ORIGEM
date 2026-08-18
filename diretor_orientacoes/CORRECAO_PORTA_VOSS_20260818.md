# Correcção da Passagem da Casa Voss — 18 de Agosto de 2026

## Diagnóstico confirmado

O vídeo reportado mostrou a porta accionada por `E`, mas Elias encontrava uma barreira ao tentar entrar no exterior. A reprodução com movimento real confirmou que as folhas da porta eram removidas, mas o `TerracoDeRevelacaoDaCasaVoss` permanecia como um `StaticBody3D` no eixo da soleira. A telemetria de colisão identificou esse corpo com uma normal frontal, reproduzindo exactamente o bloqueio relatado.

## Correcção aplicada

A abertura de porta remove agora recursivamente os colisores das folhas e descarta as duas malhas após a animação, para que nenhuma tábua visual permaneça no vão. O Terraço de Revelação e os seus degraus passaram a ser exclusivamente visuais e foram recuados da zona imediata da porta. O suporte jogável continua a ser fornecido pelo piso da casa, pela passagem rasa e pelo terreno físico exterior.

## Validação

A validação técnica do projecto passou sem erros de parse ou runtime. Numa sessão de 30 segundos, Elias abriu a porta por `E`, avançou de dentro da casa para o exterior e passou de `z=10.41278` para `z=14.54692`. Depois da correcção, a única colisão registada no avanço foi o `PisoDeMadeira_Colisao` com normal vertical, que é suporte de chão e não bloqueia a rota horizontal.

## Próximo ciclo

O pacote seguinte será criado a partir desta correcção, extraído num checkout novo e validado pelo Menu Principal, Novo Jogo e sessão de gameplay antes de ser enviado para teste.
