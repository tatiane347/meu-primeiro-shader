#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

void main() {
    // 1. Normaliza as coordenadas do pixel para o intervalo de 0 a 1
    vec2 st = gl_FragCoord.xy / u_resolution.xy;

    // 2. Cria um padrão de repetição (como azulejos)
    // O valor '3.0' define a quantidade de repetições
    vec2 tile = mod(st * 3.0, 1.0);

    // 3. Centraliza a coordenada do azulejo
    vec2 center = tile - 0.5;

    // 4. Calcula a distância do centro do azulejo
    float distance_from_center = length(center);

    // 5. Cria a animação de pulso baseada no tempo
    // O valor '0.2' e '4.0' controla a velocidade e o tamanho do pulso
    float pulse = sin(u_time * 4.0) * 0.2 + 0.5;

    // 6. Define a cor do pixel
    // A cor muda com a distância e o pulso, criando um anel animado
    vec3 color = vec3(0.0);
    color.r = distance_from_center;
    color.g = 1.0 - distance_from_center;
    color.b = pulse;
    
    // 7. Suaviza as bordas do círculo
    float smoothed_circle = smoothstep(0.4, 0.4 + pulse, distance_from_center);
    color *= 1.0 - smoothed_circle;

    // Atribui a cor final ao pixel
    gl_FragColor = vec4(color, 1.0);
}
