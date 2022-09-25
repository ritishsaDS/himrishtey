class AdvanceSearchPostModel {
  var profile_id;
  var state_name;
  var city;
  var employed_in;
  var age_from;
  var age_to;
  var height_from;
  var height_to;
  var religion;
  var mother_tongue;
  var cast;
  var manglik;
  var marital_status;
  var education;
  var annual_income;
  var family_status;
  var family_type;
  AdvanceSearchPostModel(
      {this.education,
      this.cast,
      this.religion,
      this.manglik,
      this.age_from,
      this.age_to,
      this.annual_income,
      this.city,
      this.employed_in,
      this.family_status,
      this.family_type,
      this.height_from,
      this.height_to,
      this.marital_status,
      this.mother_tongue,
      this.profile_id,
      this.state_name});
}
