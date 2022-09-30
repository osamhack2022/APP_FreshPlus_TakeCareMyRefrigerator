Future<void> resetPW(String email){
  try{
    await UserRepository().requestPasswordReset(email);
  } on UserBoxRepositoryException catch(e){
    throw CtrlException(e.code);
  }
}