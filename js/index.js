import * as THREE from 'three';
import frgmt from './shaders/shader01_frgmt.glsl';
import vrtx from './shaders/shader01_vrtx.glsl';


var container;
var headings;
var texture01;
var camera, scene, renderer;
var uniforms;


init();
animate();

function getCSSVar(element, CSSvariable){
const styles = getComputedStyle(element);
const varValue = styles.getPropertyValue(CSSvariable);

console.log('var value: '+varValue); // output: ' white'
return varValue;
}
function convertHexToGLSLRGB(hex){
    var r = parseInt(hex.substring(1,3),16)/255.0;
    var g = parseInt(hex.substring(3,5),16)/255.0;
    var b = parseInt(hex.substring(5,7),16)/255.0;
    return new THREE.Vector3(r,g,b);
}
function extractNumbersFromString(string){
    var numbers = string.match(/\d+/g).map(Number);
    console.log("numbers:"+ numbers);
    return numbers;
    
}
function getColumnWidth(){
    var grid_column_width = getCSSVar(document.body, '--unit_column');
    var widthNormalized = (extractNumbersFromString(grid_column_width)*0.01);
    return widthNormalized;
}

function init(){
    
    headings = document.getElementById('headings');
    texture01 = document.getElementsByClassName('texture01')[0];
    container = document.getElementById('container');
    camera = new THREE.Camera();
    camera.position.z = 1.0;
    scene = new THREE.Scene();
    var color_primary = convertHexToGLSLRGB(getCSSVar(document.body, '--color_primary'));
    var color_secondary = convertHexToGLSLRGB(getCSSVar(document.body, '--color_secondary'));
    var shader_speed = getCSSVar(document.body, '--shader_speed');
    var column_width = getColumnWidth();
    console.log("column_width: "+column_width);
    console.log("color primary: "+color_primary)
    


    var geometry = new THREE.PlaneBufferGeometry(2.0,2.0);
    uniforms = {
        u_time:{type:"f", value: 1.0},
        u_mouse:{type:"v2", value: new THREE.Vector2()},
        u_resolution:{type:"v2", value: new THREE.Vector2()},
        u_width:{type:"f", value: window.innerWidth},
        u_height:{type:"f", value: window.innerHeight},
        u_grid_column_width:{type:"f", value: column_width},
        u_color_primary: {type: "vec3", value: color_primary},
        u_color_secondary: {type: "vec3", value: color_secondary},
        u_shader_speed: {type: "f", value: shader_speed}
    }


    var material = new THREE.ShaderMaterial({
        uniforms:uniforms ,
        vertexShader: vrtx,
        fragmentShader: frgmt,

    });
    var mesh = new THREE.Mesh(geometry,material);
    scene.add(mesh);

    renderer = new THREE.WebGLRenderer();
    renderer.setPixelRatio(window.devicePixelRatio);
    container.appendChild(renderer.domElement);
    onWindowResize();
    window.addEventListener('resize', onWindowResize, false);
    //set container lowest z-index
    
    container.style.zIndex = 1;
    texture01.style.zIndex = 2;
    headings.style.zIndex = 3;

}
function setMousePosition(){
    
    uniforms.u_mouse.value.x = renderer.domElement.width;
    uniforms.u_mouse.value.y = renderer.domElement.height;
}
window.addEventListener('mousemove', (event) => {
    
       var mousePos = { x: event.clientX, y: event.clientY };
        uniforms.u_mouse.value.x = mousePos.x;
        uniforms.u_mouse.value.y = mousePos.y;
      });
function onWindowResize(event){
    renderer.setSize(window.innerWidth, window.innerHeight);
    uniforms.u_resolution.value.x = renderer.domElement.width;
    uniforms.u_resolution.value.y = renderer.domElement.height;

}
function animate(){
    requestAnimationFrame(animate);
    render();

}
function render(){
    uniforms.u_time.value +=0.05;
    renderer.render(scene,camera);
}