import '../../libs.dart';

void globalPrint(String text)
{
  if(!isRelease)
    {
     debugPrint(text);
    }
}