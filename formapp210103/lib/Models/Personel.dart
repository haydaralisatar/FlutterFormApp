class Personel {
  //Kişileri oluşturacağımız class
  String nameSurname,
      gender,
      phone,
      eMail,
      description,
      job; //alanlarımızı belirledik.
  DateTime dateOfBirth;
  Personel(
      {this.nameSurname,
      this.gender,
      this.phone,
      this.eMail,
      this.description,
      this.dateOfBirth,
      this.job});
}
