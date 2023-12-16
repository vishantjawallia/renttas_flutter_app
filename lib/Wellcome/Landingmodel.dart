class SliderModel{
  String? image;
  String? text;
  String? description;
// images given
  SliderModel({this.image,this.text,this.description});

// setter for image
  void setImage(String getImage){
    image = getImage;
  }
  void setText(String getText){
    text = getText;
  }
  void setDescription(String getDescription){
    description = getDescription;
  }


// getter for image
  String? getImage(){
    return image;
  }
  String? getText(){
    return text;
  }
  String? getDescription(){
    return description;
  }
}
List<SliderModel> getSlides(){
  List<SliderModel> slides = [];
  SliderModel sliderModel = new SliderModel();

// 1
  sliderModel.setImage("assets/images/propertyland.png");
  sliderModel.setText("Manage Properties");
  sliderModel.setDescription("Keep track of rent & tenants living in \n multiple properties");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

// 2
  sliderModel.setImage("assets/images/moneyland.png");
  sliderModel.setText("Manage Expenses");
  sliderModel.setDescription("Keep track of all the expenses \n occurred property wise");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

// 3
  sliderModel.setImage("assets/images/expenseland.png");
  sliderModel.setText("On Time Payment");
  sliderModel.setDescription("Send rent payment reminders to \n tenants automatically or manulally");
  slides.add(sliderModel);

  sliderModel = new SliderModel();
  return slides;
}
