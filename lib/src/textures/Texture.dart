part of ThreeD;

/**
 * @author mr.doob / http://mrdoob.com/
 * @author alteredq / http://alteredqualia.com/
 * @author szimek / https://github.com/szimek/
 *
 * Ported to Dart from JS by:
 * @author rob silverton / http://www.unwrong.com/
 */

class Texture {
  int _id;
  var image;
  var mapping; //UVMapping appears to be missing..
  int wrapS, wrapT, magFilter, minFilter, format, type, anisotropy;
  Vector2 offset, repeat;
  bool generateMipmaps;
  bool premultiplyAlpha;

  bool needsUpdate;
  var onUpdate;

  bool flipY;

  //TODO: resolve dynamic vars, find out what UVMapping is!
  Texture( [  this.image,
              this.mapping = null,
              this.wrapS = Three.ClampToEdgeWrapping,
              this.wrapT = Three.ClampToEdgeWrapping,
              this.magFilter = Three.LinearFilter,
              this.minFilter = Three.LinearMipMapLinearFilter,
              this.format = Three.RGBAFormat,
              this.type = Three.UnsignedByteType,
              this.anisotropy = 1] )
  {
    _id = Three.TextureCount ++;

    this.mapping = mapping != null ? mapping : new UVMapping();

    offset = new Vector2( 0, 0 );
    repeat = new Vector2( 1, 1 );

    generateMipmaps = true;
    premultiplyAlpha = false;
    flipY = true;

    needsUpdate = false;
    onUpdate = null;
  }

  Texture clone() {
    Texture clonedTexture = new Texture( image, mapping, wrapS, wrapT, magFilter, minFilter, format, type, anisotropy );

    clonedTexture.offset.copy( offset );
    clonedTexture.repeat.copy( repeat );

    return clonedTexture;
  }

  // Quick hack to allow setting new properties (used by the renderer)
  Map __data;

  get _data {
    if (__data == null) {
      __data = {};
    }
    return __data;
  }

  operator [] (String key) => _data[key];
  operator []= (String key, value) => _data[key] = value;
}
