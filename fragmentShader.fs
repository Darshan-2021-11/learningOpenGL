#version 330 core
out vec4 FragColor;

in vec3 ourColor;
in vec2 TexCoord;

// texture sampler
uniform sampler2D t1;
uniform sampler2D t2;

void main()
{
	FragColor = mix(texture(t1, vec2(1 - TexCoord.x, TexCoord.y)), texture(t2, TexCoord),
	0.5) * vec4(ourColor, 1.0);
}
