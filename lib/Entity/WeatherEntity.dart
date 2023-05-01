// ignore: file_names
// ignore_for_file: unnecessary_new, unnecessary_this

class WeatherEntity {
  num? now;
  String? nowDt;
  Info? info;
  GeoObject? geoObject;
  Yesterday? yesterday;
  Fact? fact;
  List<Forecasts>? forecasts;

  WeatherEntity(
      {this.now,
      this.nowDt,
      this.info,
      this.geoObject,
      this.yesterday,
      this.fact,
      this.forecasts});

  WeatherEntity.fromJson(Map<String, dynamic> json) {
    now = json['now'];
    nowDt = json['now_dt'];
    info = json['info'] != null ? Info.fromJson(json['info']) : null;
    geoObject = json['geo_object'] != null
        ? GeoObject.fromJson(json['geo_object'])
        : null;
    yesterday = json['yesterday'] != null
        ? new Yesterday.fromJson(json['yesterday'])
        : null;
    fact = json['fact'] != null ? new Fact.fromJson(json['fact']) : null;
    if (json['forecasts'] != null) {
      forecasts = <Forecasts>[];
      json['forecasts'].forEach((v) {
        forecasts!.add(new Forecasts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['now'] = this.now;
    data['now_dt'] = this.nowDt;
    if (this.info != null) {
      data['info'] = this.info!.toJson();
    }
    if (this.geoObject != null) {
      data['geo_object'] = this.geoObject!.toJson();
    }
    if (this.yesterday != null) {
      data['yesterday'] = this.yesterday!.toJson();
    }
    if (this.fact != null) {
      data['fact'] = this.fact!.toJson();
    }
    if (this.forecasts != null) {
      data['forecasts'] = this.forecasts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Info {
  bool? n;
  num? geoid;
  String? url;
  num? lat;
  num? lon;
  Tzinfo? tzinfo;
  num? defPressureMm;
  num? defPressurePa;
  String? slug;
  num? zoom;
  bool? nr;
  bool? ns;
  bool? nsr;
  bool? p;
  bool? f;
  bool? bH;

  Info(
      {this.n,
      this.geoid,
      this.url,
      this.lat,
      this.lon,
      this.tzinfo,
      this.defPressureMm,
      this.defPressurePa,
      this.slug,
      this.zoom,
      this.nr,
      this.ns,
      this.nsr,
      this.p,
      this.f,
      this.bH});

  Info.fromJson(Map<String, dynamic> json) {
    n = json['n'];
    geoid = json['geoid'];
    url = json['url'];
    lat = json['lat'];
    lon = json['lon'];
    tzinfo =
        json['tzinfo'] != null ? new Tzinfo.fromJson(json['tzinfo']) : null;
    defPressureMm = json['def_pressure_mm'];
    defPressurePa = json['def_pressure_pa'];
    slug = json['slug'];
    zoom = json['zoom'];
    nr = json['nr'];
    ns = json['ns'];
    nsr = json['nsr'];
    p = json['p'];
    f = json['f'];
    bH = json['_h'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['n'] = this.n;
    data['geoid'] = this.geoid;
    data['url'] = this.url;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    if (this.tzinfo != null) {
      data['tzinfo'] = this.tzinfo!.toJson();
    }
    data['def_pressure_mm'] = this.defPressureMm;
    data['def_pressure_pa'] = this.defPressurePa;
    data['slug'] = this.slug;
    data['zoom'] = this.zoom;
    data['nr'] = this.nr;
    data['ns'] = this.ns;
    data['nsr'] = this.nsr;
    data['p'] = this.p;
    data['f'] = this.f;
    data['_h'] = this.bH;
    return data;
  }
}

class Tzinfo {
  String? name;
  String? abbr;
  bool? dst;
  num? offset;

  Tzinfo({this.name, this.abbr, this.dst, this.offset});

  Tzinfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    abbr = json['abbr'];
    dst = json['dst'];
    offset = json['offset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = this.name;
    data['abbr'] = this.abbr;
    data['dst'] = this.dst;
    data['offset'] = this.offset;
    return data;
  }
}

class GeoObject {
  District? district;
  District? locality;
  District? province;
  District? country;

  GeoObject({this.district, this.locality, this.province, this.country});

  GeoObject.fromJson(Map<String, dynamic> json) {
    district = json['district'] != null
        ? new District.fromJson(json['district'])
        : null;
    locality = json['locality'] != null
        ? new District.fromJson(json['locality'])
        : null;
    province = json['province'] != null
        ? new District.fromJson(json['province'])
        : null;
    country =
        json['country'] != null ? new District.fromJson(json['country']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.district != null) {
      data['district'] = this.district!.toJson();
    }
    if (this.locality != null) {
      data['locality'] = this.locality!.toJson();
    }
    if (this.province != null) {
      data['province'] = this.province!.toJson();
    }
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    return data;
  }
}

class District {
  num? id;
  String? name;

  District({this.id, this.name});

  District.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Yesterday {
  num? temp;

  Yesterday({this.temp});

  Yesterday.fromJson(Map<String, dynamic> json) {
    temp = json['temp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['temp'] = this.temp;
    return data;
  }
}

class Fact {
  num? obsTime;
  num? uptime;
  num? temp;
  num? feelsLike;
  String? icon;
  String? condition;
  num? cloudness;
  num? precType;
  num? precProb;
  num? precStrength;
  bool? isThunder;
  num? windSpeed;
  String? windDir;
  num? pressureMm;
  num? pressurePa;
  num? humidity;
  String? daytime;
  bool? polar;
  String? season;
  String? source;
  num? soilMoisture;
  num? soilTemp;
  num? uvIndex;
  num? windGust;

  Map<String,dynamic> toMap()
    => {
      'obsTime' : obsTime,
      'uptime' : uptime,
      'temp': temp,
      'feelsLike': feelsLike,
      'icon':icon,
      'condition' : condition,
      'cloudness' : cloudness,
      'precType' : precType
    };
  

  Fact(
      {this.obsTime,
      this.uptime,
      this.temp,
      this.feelsLike,
      this.icon,
      this.condition,
      this.cloudness,
      this.precType,
      this.precProb,
      this.precStrength,
      this.isThunder,
      this.windSpeed,
      this.windDir,
      this.pressureMm,
      this.pressurePa,
      this.humidity,
      this.daytime,
      this.polar,
      this.season,
      this.source,
      this.soilMoisture,
      this.soilTemp,
      this.uvIndex,
      this.windGust});
  


  Fact.fromJson(Map<String, dynamic> json) {
    obsTime = json['obs_time'];
    uptime = json['uptime'];
    temp = json['temp'];
    feelsLike = json['feels_like'];
    icon = json['icon'];
    condition = json['condition'];
    cloudness = json['cloudness'];
    precType = json['prec_type'];
    precProb = json['prec_prob'];
    precStrength = json['prec_strength'];
    isThunder = json['is_thunder'];
    windSpeed = json['wind_speed'];
    windDir = json['wind_dir'];
    pressureMm = json['pressure_mm'];
    pressurePa = json['pressure_pa'];
    humidity = json['humidity'];
    daytime = json['daytime'];
    polar = json['polar'];
    season = json['season'];
    source = json['source'];
    soilMoisture = json['soil_moisture'];
    soilTemp = json['soil_temp'];
    uvIndex = json['uv_index'];
    windGust = json['wind_gust'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['obs_time'] = this.obsTime;
    data['uptime'] = this.uptime;
    data['temp'] = this.temp;
    data['feels_like'] = this.feelsLike;
    data['icon'] = this.icon;
    data['condition'] = this.condition;
    data['cloudness'] = this.cloudness;
    data['prec_type'] = this.precType;
    data['prec_prob'] = this.precProb;
    data['prec_strength'] = this.precStrength;
    data['is_thunder'] = this.isThunder;
    data['wind_speed'] = this.windSpeed;
    data['wind_dir'] = this.windDir;
    data['pressure_mm'] = this.pressureMm;
    data['pressure_pa'] = this.pressurePa;
    data['humidity'] = this.humidity;
    data['daytime'] = this.daytime;
    data['polar'] = this.polar;
    data['season'] = this.season;
    data['source'] = this.source;
    data['soil_moisture'] = this.soilMoisture;
    data['soil_temp'] = this.soilTemp;
    data['uv_index'] = this.uvIndex;
    data['wind_gust'] = this.windGust;
    return data;
  }
}

class Forecasts {
  String? date;
  num? dateTs;
  num? week;
  String? sunrise;
  String? sunset;
  String? riseBegin;
  String? setEnd;
  num? moonCode;
  String? moonText;
  Parts? parts;
  List<Hours>? hours;
  Biomet? biomet;

  Forecasts(
      {this.date,
      this.dateTs,
      this.week,
      this.sunrise,
      this.sunset,
      this.riseBegin,
      this.setEnd,
      this.moonCode,
      this.moonText,
      this.parts,
      this.hours,
      this.biomet});

  Forecasts.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    dateTs = json['date_ts'];
    week = json['week'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
    riseBegin = json['rise_begin'];
    setEnd = json['set_end'];
    moonCode = json['moon_code'];
    moonText = json['moon_text'];
    parts = json['parts'] != null ? new Parts.fromJson(json['parts']) : null;
    if (json['hours'] != null) {
      hours = <Hours>[];
      json['hours'].forEach((v) {
        hours!.add(new Hours.fromJson(v));
      });
    }
    biomet =
        json['biomet'] != null ? new Biomet.fromJson(json['biomet']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = this.date;
    data['date_ts'] = this.dateTs;
    data['week'] = this.week;
    data['sunrise'] = this.sunrise;
    data['sunset'] = this.sunset;
    data['rise_begin'] = this.riseBegin;
    data['set_end'] = this.setEnd;
    data['moon_code'] = this.moonCode;
    data['moon_text'] = this.moonText;
    if (this.parts != null) {
      data['parts'] = this.parts!.toJson();
    }
    if (this.hours != null) {
      data['hours'] = this.hours!.map((v) => v.toJson()).toList();
    }
    if (this.biomet != null) {
      data['biomet'] = this.biomet!.toJson();
    }
    return data;
  }
}

class Parts {
  Day? day;
  DayShort? dayShort;
  Day? night;
  NightShort? nightShort;
  Day? morning;
  Day? evening;

  Parts(
      {this.day,
      this.dayShort,
      this.night,
      this.nightShort,
      this.morning,
      this.evening});

  Parts.fromJson(Map<String, dynamic> json) {
    day = json['day'] != null ? new Day.fromJson(json['day']) : null;
    dayShort = json['day_short'] != null
        ? new DayShort.fromJson(json['day_short'])
        : null;
    night = json['night'] != null ? new Day.fromJson(json['night']) : null;
    nightShort = json['night_short'] != null
        ? new NightShort.fromJson(json['night_short'])
        : null;
    morning =
        json['morning'] != null ? new Day.fromJson(json['morning']) : null;
    evening =
        json['evening'] != null ? new Day.fromJson(json['evening']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.day != null) {
      data['day'] = this.day!.toJson();
    }
    if (this.dayShort != null) {
      data['day_short'] = this.dayShort!.toJson();
    }
    if (this.night != null) {
      data['night'] = this.night!.toJson();
    }
    if (this.nightShort != null) {
      data['night_short'] = this.nightShort!.toJson();
    }
    if (this.morning != null) {
      data['morning'] = this.morning!.toJson();
    }
    if (this.evening != null) {
      data['evening'] = this.evening!.toJson();
    }
    return data;
  }
}

class Day {
  String? sSource;
  num? tempMin;
  num? tempAvg;
  num? tempMax;
  num? windSpeed;
  num? windGust;
  String? windDir;
  num? pressureMm;
  num? pressurePa;
  num? humidity;
  num? soilTemp;
  num? soilMoisture;
  num? precMm;
  num? precProb;
  num? precPeriod;
  num? cloudness;
  num? precType;
  num? precStrength;
  String? icon;
  String? condition;
  num? uvIndex;
  num? feelsLike;
  String? daytime;
  bool? polar;
  num? freshSnowMm;

  Day(
      {this.sSource,
      this.tempMin,
      this.tempAvg,
      this.tempMax,
      this.windSpeed,
      this.windGust,
      this.windDir,
      this.pressureMm,
      this.pressurePa,
      this.humidity,
      this.soilTemp,
      this.soilMoisture,
      this.precMm,
      this.precProb,
      this.precPeriod,
      this.cloudness,
      this.precType,
      this.precStrength,
      this.icon,
      this.condition,
      this.uvIndex,
      this.feelsLike,
      this.daytime,
      this.polar,
      this.freshSnowMm});

  Day.fromJson(Map<String, dynamic> json) {
    sSource = json['_source'];
    tempMin = json['temp_min'];
    tempAvg = json['temp_avg'];
    tempMax = json['temp_max'];
    windSpeed = json['wind_speed'];
    windGust = json['wind_gust'];
    windDir = json['wind_dir'];
    pressureMm = json['pressure_mm'];
    pressurePa = json['pressure_pa'];
    humidity = json['humidity'];
    soilTemp = json['soil_temp'];
    soilMoisture = json['soil_moisture'];
    precMm = json['prec_mm'];
    precProb = json['prec_prob'];
    precPeriod = json['prec_period'];
    cloudness = json['cloudness'];
    precType = json['prec_type'];
    precStrength = json['prec_strength'];
    icon = json['icon'];
    condition = json['condition'];
    uvIndex = json['uv_index'];
    feelsLike = json['feels_like'];
    daytime = json['daytime'];
    polar = json['polar'];
    freshSnowMm = json['fresh_snow_mm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_source'] = this.sSource;
    data['temp_min'] = this.tempMin;
    data['temp_avg'] = this.tempAvg;
    data['temp_max'] = this.tempMax;
    data['wind_speed'] = this.windSpeed;
    data['wind_gust'] = this.windGust;
    data['wind_dir'] = this.windDir;
    data['pressure_mm'] = this.pressureMm;
    data['pressure_pa'] = this.pressurePa;
    data['humidity'] = this.humidity;
    data['soil_temp'] = this.soilTemp;
    data['soil_moisture'] = this.soilMoisture;
    data['prec_mm'] = this.precMm;
    data['prec_prob'] = this.precProb;
    data['prec_period'] = this.precPeriod;
    data['cloudness'] = this.cloudness;
    data['prec_type'] = this.precType;
    data['prec_strength'] = this.precStrength;
    data['icon'] = this.icon;
    data['condition'] = this.condition;
    data['uv_index'] = this.uvIndex;
    data['feels_like'] = this.feelsLike;
    data['daytime'] = this.daytime;
    data['polar'] = this.polar;
    data['fresh_snow_mm'] = this.freshSnowMm;
    return data;
  }
}

class DayShort {
  String? sSource;
  num? temp;
  num? tempMin;
  num? windSpeed;
  num? windGust;
  String? windDir;
  num? pressureMm;
  num? pressurePa;
  num? humidity;
  num? soilTemp;
  num? soilMoisture;
  num? precMm;
  num? precProb;
  num? precPeriod;
  num? cloudness;
  num? precType;
  num? precStrength;
  String? icon;
  String? condition;
  num? uvIndex;
  num? feelsLike;
  String? daytime;
  bool? polar;
  num? freshSnowMm;

  DayShort(
      {this.sSource,
      this.temp,
      this.tempMin,
      this.windSpeed,
      this.windGust,
      this.windDir,
      this.pressureMm,
      this.pressurePa,
      this.humidity,
      this.soilTemp,
      this.soilMoisture,
      this.precMm,
      this.precProb,
      this.precPeriod,
      this.cloudness,
      this.precType,
      this.precStrength,
      this.icon,
      this.condition,
      this.uvIndex,
      this.feelsLike,
      this.daytime,
      this.polar,
      this.freshSnowMm});

  DayShort.fromJson(Map<String, dynamic> json) {
    sSource = json['_source'];
    temp = json['temp'];
    tempMin = json['temp_min'];
    windSpeed = json['wind_speed'];
    windGust = json['wind_gust'];
    windDir = json['wind_dir'];
    pressureMm = json['pressure_mm'];
    pressurePa = json['pressure_pa'];
    humidity = json['humidity'];
    soilTemp = json['soil_temp'];
    soilMoisture = json['soil_moisture'];
    precMm = json['prec_mm'];
    precProb = json['prec_prob'];
    precPeriod = json['prec_period'];
    cloudness = json['cloudness'];
    precType = json['prec_type'];
    precStrength = json['prec_strength'];
    icon = json['icon'];
    condition = json['condition'];
    uvIndex = json['uv_index'];
    feelsLike = json['feels_like'];
    daytime = json['daytime'];
    polar = json['polar'];
    freshSnowMm = json['fresh_snow_mm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_source'] = this.sSource;
    data['temp'] = this.temp;
    data['temp_min'] = this.tempMin;
    data['wind_speed'] = this.windSpeed;
    data['wind_gust'] = this.windGust;
    data['wind_dir'] = this.windDir;
    data['pressure_mm'] = this.pressureMm;
    data['pressure_pa'] = this.pressurePa;
    data['humidity'] = this.humidity;
    data['soil_temp'] = this.soilTemp;
    data['soil_moisture'] = this.soilMoisture;
    data['prec_mm'] = this.precMm;
    data['prec_prob'] = this.precProb;
    data['prec_period'] = this.precPeriod;
    data['cloudness'] = this.cloudness;
    data['prec_type'] = this.precType;
    data['prec_strength'] = this.precStrength;
    data['icon'] = this.icon;
    data['condition'] = this.condition;
    data['uv_index'] = this.uvIndex;
    data['feels_like'] = this.feelsLike;
    data['daytime'] = this.daytime;
    data['polar'] = this.polar;
    data['fresh_snow_mm'] = this.freshSnowMm;
    return data;
  }
}

class NightShort {
  String? sSource;
  num? temp;
  num? windSpeed;
  num? windGust;
  String? windDir;
  num? pressureMm;
  num? pressurePa;
  num? humidity;
  num? soilTemp;
  num? soilMoisture;
  num? precMm;
  num? precProb;
  num? precPeriod;
  num? cloudness;
  num? precType;
  num? precStrength;
  String? icon;
  String? condition;
  num? uvIndex;
  num? feelsLike;
  String? daytime;
  bool? polar;
  num? freshSnowMm;

  NightShort(
      {this.sSource,
      this.temp,
      this.windSpeed,
      this.windGust,
      this.windDir,
      this.pressureMm,
      this.pressurePa,
      this.humidity,
      this.soilTemp,
      this.soilMoisture,
      this.precMm,
      this.precProb,
      this.precPeriod,
      this.cloudness,
      this.precType,
      this.precStrength,
      this.icon,
      this.condition,
      this.uvIndex,
      this.feelsLike,
      this.daytime,
      this.polar,
      this.freshSnowMm});

  NightShort.fromJson(Map<String, dynamic> json) {
    sSource = json['_source'];
    temp = json['temp'];
    windSpeed = json['wind_speed'];
    windGust = json['wind_gust'];
    windDir = json['wind_dir'];
    pressureMm = json['pressure_mm'];
    pressurePa = json['pressure_pa'];
    humidity = json['humidity'];
    soilTemp = json['soil_temp'];
    soilMoisture = json['soil_moisture'];
    precMm = json['prec_mm'];
    precProb = json['prec_prob'];
    precPeriod = json['prec_period'];
    cloudness = json['cloudness'];
    precType = json['prec_type'];
    precStrength = json['prec_strength'];
    icon = json['icon'];
    condition = json['condition'];
    uvIndex = json['uv_index'];
    feelsLike = json['feels_like'];
    daytime = json['daytime'];
    polar = json['polar'];
    freshSnowMm = json['fresh_snow_mm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_source'] = this.sSource;
    data['temp'] = this.temp;
    data['wind_speed'] = this.windSpeed;
    data['wind_gust'] = this.windGust;
    data['wind_dir'] = this.windDir;
    data['pressure_mm'] = this.pressureMm;
    data['pressure_pa'] = this.pressurePa;
    data['humidity'] = this.humidity;
    data['soil_temp'] = this.soilTemp;
    data['soil_moisture'] = this.soilMoisture;
    data['prec_mm'] = this.precMm;
    data['prec_prob'] = this.precProb;
    data['prec_period'] = this.precPeriod;
    data['cloudness'] = this.cloudness;
    data['prec_type'] = this.precType;
    data['prec_strength'] = this.precStrength;
    data['icon'] = this.icon;
    data['condition'] = this.condition;
    data['uv_index'] = this.uvIndex;
    data['feels_like'] = this.feelsLike;
    data['daytime'] = this.daytime;
    data['polar'] = this.polar;
    data['fresh_snow_mm'] = this.freshSnowMm;
    return data;
  }
}

class Hours {
  String? hour;
  num? hourTs;
  num? temp;
  num? feelsLike;
  String? icon;
  String? condition;
  num? cloudness;
  num? precType;
  num? precStrength;
  bool? isThunder;
  String? windDir;
  num? windSpeed;
  num? windGust;
  num? pressureMm;
  num? pressurePa;
  num? humidity;
  num? uvIndex;
  num? soilTemp;
  num? soilMoisture;
  num? precMm;
  num? precPeriod;
  num? precProb;

  Hours(
      {this.hour,
      this.hourTs,
      this.temp,
      this.feelsLike,
      this.icon,
      this.condition,
      this.cloudness,
      this.precType,
      this.precStrength,
      this.isThunder,
      this.windDir,
      this.windSpeed,
      this.windGust,
      this.pressureMm,
      this.pressurePa,
      this.humidity,
      this.uvIndex,
      this.soilTemp,
      this.soilMoisture,
      this.precMm,
      this.precPeriod,
      this.precProb});

  Hours.fromJson(Map<String, dynamic> json) {
    hour = json['hour'];
    hourTs = json['hour_ts'];
    temp = json['temp'];
    feelsLike = json['feels_like'];
    icon = json['icon'];
    condition = json['condition'];
    cloudness = json['cloudness'];
    precType = json['prec_type'];
    precStrength = json['prec_strength'];
    isThunder = json['is_thunder'];
    windDir = json['wind_dir'];
    windSpeed = json['wind_speed'];
    windGust = json['wind_gust'];
    pressureMm = json['pressure_mm'];
    pressurePa = json['pressure_pa'];
    humidity = json['humidity'];
    uvIndex = json['uv_index'];
    soilTemp = json['soil_temp'];
    soilMoisture = json['soil_moisture'];
    precMm = json['prec_mm'];
    precPeriod = json['prec_period'];
    precProb = json['prec_prob'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hour'] = this.hour;
    data['hour_ts'] = this.hourTs;
    data['temp'] = this.temp;
    data['feels_like'] = this.feelsLike;
    data['icon'] = this.icon;
    data['condition'] = this.condition;
    data['cloudness'] = this.cloudness;
    data['prec_type'] = this.precType;
    data['prec_strength'] = this.precStrength;
    data['is_thunder'] = this.isThunder;
    data['wind_dir'] = this.windDir;
    data['wind_speed'] = this.windSpeed;
    data['wind_gust'] = this.windGust;
    data['pressure_mm'] = this.pressureMm;
    data['pressure_pa'] = this.pressurePa;
    data['humidity'] = this.humidity;
    data['uv_index'] = this.uvIndex;
    data['soil_temp'] = this.soilTemp;
    data['soil_moisture'] = this.soilMoisture;
    data['prec_mm'] = this.precMm;
    data['prec_period'] = this.precPeriod;
    data['prec_prob'] = this.precProb;
    return data;
  }
}

class Biomet {
  num? index;
  String? condition;

  Biomet({this.index, this.condition});

  Biomet.fromJson(Map<String, dynamic> json) {
    index = json['index'];
    condition = json['condition'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['index'] = this.index;
    data['condition'] = this.condition;
    return data;
  }
}
